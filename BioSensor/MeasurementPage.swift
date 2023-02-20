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

    @Binding var currentDate:Date
    @Binding var reading:[Reading]
    @Binding var textInput:String
    
    var tmp = listView()
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
                    tmp
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
    
    @StateObject private var dataController = DataController()
    @State private var measurements = DataController().fetchTilt()
    
    var body:some View{
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
        } //Delete this line after data integration
    }
    
}
