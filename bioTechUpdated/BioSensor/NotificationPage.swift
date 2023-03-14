//
//  NotificationPage.swift
//  BioSensor
//
//  Created by Shi Xiang Lim on 2/7/23.
//

import Foundation
import SwiftUI


struct Notification: View {
    @Binding var currentDate:Date
    var body: some View {
        ZStack{
            Color(red: 0.50, green: 0.82, blue: 0.96).edgesIgnoringSafeArea(.all)
            VStack{
                
//                HStack{
//                    Text("Reminders")
//                        .font(.largeTitle)
//                        .underline()
//                        .padding()
//                        .fontWeight(.medium)
//                        .foregroundColor(Color.accentColor)
//                }
                
                
                List {
                    HStack{
                        DatePicker("",
                                   selection: $currentDate,displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .frame(width: 150, height: 80, alignment: .leading)
                        .clipped()
                        Spacer()
                        Toggle(isOn: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Is On@*/.constant(true)/*@END_MENU_TOKEN@*/) {
                            
                        }
                    }
                    .listRowBackground(Color.clear)
                    HStack{
                        DatePicker("",
                                   selection: $currentDate,displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .frame(width: 150, height: 80, alignment: .leading)
                        .clipped()
                        Spacer()
                        Toggle(isOn: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Is On@*/.constant(true)/*@END_MENU_TOKEN@*/) {
                            
                        }
                    }
                    .listRowBackground(Color.clear)
                }
                .scrollContentBackground(.hidden)
                .padding()
                
                
                HStack{
                    
                    Button {
                        print("Plus tapped!")
                    } label: {
                        Image(systemName: "plus.square")
                    }
                    .font(.system(size: 40))
                    .frame(width: 50, height: 50)
                    .foregroundColor(Color.accentColor)
                    
                    Button {
                        print("Minus tapped!")
                    } label: {
                        Image(systemName: "minus.square")
                    }
                    .font(.system(size: 40))
                    .frame(width: 50, height: 50)
                    .foregroundColor(Color.accentColor)
                    
                }
                .padding()

            }
            Spacer()

        }
    }
}
