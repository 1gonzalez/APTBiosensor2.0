//
//  MeasurementPage.swift
//  BioSensor
//
//  Created by Shi Xiang Lim on 2/7/23.
//

import Foundation
import SwiftUI
import Charts
import CoreData

/*
 ToDo: Currently pending on determining how the data is saved.
    - Create a filter function using the date picker.
    - Figure out how to grab data and insert into list.
 */



struct Measurement: View {

    @State var currentDate = Date.now
    var body: some View {
        ZStack{
            Color(red: 0.50, green: 0.82, blue: 0.96).edgesIgnoringSafeArea(.all)
            VStack{
                MLPredictedData()
                Spacer()
                HStack{
                    Spacer()
                    DatePicker("",
                               selection: $currentDate,displayedComponents: .date)
                        .labelsHidden()
                        .frame(width: 150, height: 80, alignment: .center)
                        .clipped()
                    
                    Spacer()
                }
                Spacer()
                HStack{
                    listView(dateFilter:$currentDate)
                    Spacer()
                }
                Spacer()
            }
        }
    }
}

struct measurementData{
    let id = UUID()
    //let date= Date.now.formatted()    Uncomment when implementing
    let date:Date
    let data: String
}

struct measurementRow:View{
    var measurement : measurementData
    
    var body: some View{
        HStack{
            Text("\(measurement.date)")
            Spacer()
            Text("\(measurement.data)")
        }
    }
}

struct listView:View{
    var dateFilter:Binding<Date>
    var dateSelected:Date
    @FetchRequest var fetchRequest: FetchedResults<Tilt>
    
    init(dateFilter:Binding<Date>){
        self.dateFilter = dateFilter
        self.dateSelected = dateFilter.wrappedValue
        _fetchRequest = FetchRequest<Tilt>(
                sortDescriptors: [NSSortDescriptor(keyPath: \Tilt.dateTime, ascending: true)],
                predicate: NSPredicate(
                    format: "dateTime >= %@ AND dateTime <= %@",
                    Calendar.current.startOfDay(for: dateSelected) as CVarArg,
                    Calendar.current.startOfDay(for: Calendar.current.date(
                        byAdding:Calendar.Component.day,
                        value: 1,
                        to: Calendar.current.startOfDay(
                            for: dateSelected)
                    ) ?? Date.now) as CVarArg))
    }

    @Environment(\.managedObjectContext) private var viewContext
    
    var body:some View{
        let ave:Double = Double(fetchRequest.map{$0.pitch}.reduce(0.00,+) / Double(fetchRequest.count))
        VStack{
            Chart {
                ForEach(fetchRequest,id:\.id) { item in
                    PointMark(
                        x: .value("Date", (item.dateTime ?? Date.now).formatted(date:.omitted,time:.shortened)),
                        y: .value("Temp", item.pitch)
                    )
                    RuleMark(y: .value("Average", ave))
                        .foregroundStyle(getColor(val:ave))
                        .lineStyle(StrokeStyle(lineWidth: 2))
                        .annotation(position: .bottom, alignment: .trailing) {
                            Text("Average: \(ave, format: .number.precision(.fractionLength(1)))")
                                .font(.body.bold())
                                .foregroundStyle(.red)
                        }
                }
            }
            
            .chartPlotStyle { plotContent in
                plotContent
                    .background(.white.opacity(1.0))
                    .border(Color.blue, width: 2)
            }
            .frame(width: UIScreen.main.bounds.width*7/8, height: UIScreen.main.bounds.height*1/3)
            .chartYAxis {
                        AxisMarks(position: .leading)
                    }
            .chartYScale(domain: 0...35)
            .clipped(antialiased:true)
            Spacer()
            
            NavigationView {
                List {
                    ForEach(fetchRequest) { item in
                        NavigationLink {
                            Text("Gait Data")
                        } label: {
                            HStack{
                                Text((item.dateTime ?? Date.now).formatted())
                                Spacer()
                                Text("\(item.pitch,format: .number.precision(.fractionLength(2)))°")
                            }
                            
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
                /*
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                       EditButton()
                    }
                    ToolbarItem {
                        Button(action: addItem) {
                            Label("Add Item", systemImage: "plus")
                        }
                    }
                }
                Text("Select an item")*/
            }
        }
    }
    
    private func addItem() {
        withAnimation {
            let newItem = Tilt(context: viewContext)
            newItem.dateTime = Date()
            newItem.pitch = Double.random(in:1...40)
            newItem.id = UUID()
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                print(nsError)
            }
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { fetchRequest[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                print(nsError)
            }
        }
    }
    
    private func getColor(val:Double)->Color{
        let s = val
        let greenLimit = 8.00
        let yellowLimit = 10.00
        if(s < greenLimit){
            return Color.green
        }
        else if(s<yellowLimit){
            return Color.yellow
        }
        else{
            return Color.red
        }
    }
}


struct MLPredictedData:View{
    var body:some View{
        VStack{
            Text(predict1())
        }
    }
    
    private func predict1()->String{
        let model = APTRegression_1_copy_13()
        guard let modeloutput = try? model.prediction(HipRightX:-0.127274,HipRightYAngle:0.894333*180/3.1415) else {
            fatalError("Unexpected runtime error.")
        }
        let answer = modeloutput.Right_Tilt
        return String(answer)
    }
}
