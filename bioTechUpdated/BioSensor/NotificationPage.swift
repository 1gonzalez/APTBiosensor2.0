//
//  NotificationPage.swift
//  BioSensor
//
//  Created by Shi Xiang Lim on 2/7/23.
//

import Foundation
import SwiftUI
import UserNotifications


struct Notification: View {
    @Binding var currentDate:Date
    @State private var notify = false
    @FetchRequest(sortDescriptors: []) var notifs: FetchedResults<Notifications>
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
                
                List(notifs) { index in
                    Text("My List \(index)")
                }

                /*
                List(notifs) {_ in
                }
                .listRowBackground(Color.clear)
                .scrollContentBackground(.hidden)
                .padding()
                 */
                
                
                HStack{
                    
                    /*
                    Button {
                        NewNotification()
                        print("Plus tapped!")
                    } label: {
                        Image(systemName: "plus.square")
                    }
                    .font(.system(size: 40))
                    .frame(width: 50, height: 50)
                    .foregroundColor(Color.accentColor)
                     */
                    NavigationLink(destination: NewNotification(), label: {
                        Image(systemName: "plus.square")
                    })
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
            Button(action: {
                let content = UNMutableNotificationContent()
                content.title = "Time to Measure!"
                content.subtitle = "Click here to open APTBiosensor and complete your measurement."
                
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                
                UNUserNotificationCenter.current().add(request)
            }) {
                Text("Notification Demo")
            }

        }
    }
}

/*
 Use the following for when implemeting in iOS 14 and lower
 
 struct ContentView: View {
     @State private var isToggle : Bool = false {
             didSet {
                 print("value did change")
             }
     }

     var body: some View {
         Toggle(isOn: self.$isToggle){
                     Text("Toggle Label ")
          }
     }
 
 
 also refer to here https://stackoverflow.com/questions/56996272/how-can-i-trigger-an-action-when-a-swiftui-toggle-is-toggled
 }*/
