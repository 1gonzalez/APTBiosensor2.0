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
    @Binding var reading:[Reading]
    @Binding var textInput:String
    @State var currentDateNSDate:NSDate = Date.now as NSDate
    var body: some View {
        ZStack{
            Color(red: 0.50, green: 0.82, blue: 0.96).edgesIgnoringSafeArea(.all)
            VStack{
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
    @Binding var dateFilter:Date
    
    @Binding var amount: Double
    @FetchRequest var fetchRequest: FetchedResults<Tilt>
    
    
    init(filter: Date) {
        _fetchRequest = FetchRequest<Tilt>(
            sortDescriptors: [NSSortDescriptor(keyPath: \Tilt.dateTime, ascending: true)],
            predicate: NSPredicate(format: "dateTime >= %@ AND dateTime <= %@",Calendar.current.startOfDay(for: filter) as CVarArg,Calendar.current.startOfDay(byAdding: .day, value: 1, to: Calendar.current.startOfDay(for: filter), for: filter) as CVarArg),
            animation: .default)
    }

    @Environment(\.managedObjectContext) private var viewContext
    
    /*@FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Tilt.dateTime, ascending: true)],
        predicate: NSPredicate(format: "dateTime >= %@ AND dateTime <= %@",Calendar.current.startOfDay(for: dateFilter) as CVarArg,Calendar.current.startOfDay(for: dateFilter) as CVarArg),
        animation: .default
    )*/
    private var items: FetchedResults<Tilt>
    
    
    var body:some View{
        
        NavigationView {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        Text("Gait Data")
                    } label: {
                        HStack{
                            Text((item.dateTime ?? Date.now).formatted())
                            Spacer()
                            Text(item.pitch.description)
                        }
                        
                    }
                }
                .onDelete(perform: deleteItems)
            }
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
            Text("Select an item")
        }
    }
    
    private func addItem() {
        withAnimation {
            let newItem = Tilt(context: viewContext)
            newItem.dateTime = Date()
            newItem.pitch = 22.3
            newItem.id = UUID()
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                print(nsError)
                //fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                print(nsError)
                //fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}
        /*
         VStack{ //Delete this line after data integration
         //Delete from here
         Chart {
         ForEach(measurements,id:\.id) { item in
         LineMark(
         x: .value("Date", item.dateTime ?? Date.now),
         y: .value("Temp", item.pitch)
         )
         }
         }
         .chartPlotStyle { plotContent in
         plotContent
         .background(.white.opacity(1.0))
         .border(Color.blue, width: 2)
         }
         .frame(width: UIScreen.main.bounds.width*7/8, height: UIScreen.main.bounds.height*1/3)
         
         //Delete To Here
         NavigationView{
         List{ForEach(measurements, id:\.id) {measure in
         measurementRow(measurement:
         measurementData(date: measure.dateTime ?? Date.now, data: String(measure.pitch))
         )
         }.onDelete{
         indexSet in
         print(indexSet)
         
         }
         } .navigationBarTitle("Data", displayMode: .inline)
         }
         } //Delete this line after data integration*/
    
    
