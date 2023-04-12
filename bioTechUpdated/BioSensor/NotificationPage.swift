//
//  NotificationPage.swift
//  BioSensor
//
//  Created by Shi Xiang Lim on 2/7/23.
//

import Foundation
import SwiftUI
import UserNotifications
import CoreData

//Gotta fix background
struct Notification: View {
    @FetchRequest(sortDescriptors: []) var notifs: FetchedResults<Notifications>
    @Environment(\.managedObjectContext) var moc
    
    var body: some View {
        ZStack{
            Color(red: 0.50, green: 0.82, blue: 0.96).edgesIgnoringSafeArea(.all)
            VStack{
                Text("Notifications")
                    .bold()
                    .font(.title)
                    .foregroundColor(Color(red: 0.98, green: 0.69, blue: 0.27))
                    .onAppear {
                        self.makeDefaultNotifs()
                    }
//                HStack{
//                    Text("Reminders")
//                        .font(.largeTitle)
//                        .underline()
//                        .padding()
//                        .fontWeight(.medium)
//                        .foregroundColor(Color.accentColor)
//                }
                
                    
            List {
                ForEach(notifs) { index in
                    NavigationLink {
                        ChangeNotification(notification: index)
                    } label: {
                        HStack {
                            VStack(alignment: .leading, content: {
                                Text(index.time?.formatted(date: .omitted, time: .shortened) ?? "Error")
                                    .bold()
                                    .font(.title)
                                Text(index.title ?? "Label error")
                                    .font(.body)
                            })
                            .listRowBackground(Color.clear)
                            Toggle("", isOn: Binding(get: {index.isOn}, set: {_,_ in
                                if (index.isOn == true) {
                                    index.isOn = false
                                    
                                    UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: [index.id!.uuidString])
                                    UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [index.id!.uuidString])
                                }
                                else {
                                    index.isOn = true
                                    
                                    let content = UNMutableNotificationContent()
                                    content.title = "APTBiosensor"
                                    content.subtitle = index.title!
                                    content.sound = UNNotificationSound.default
                                    
                                    let dateComp = Calendar.current.dateComponents([.hour, .minute], from: index.time!)
                                    
                                    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComp, repeats: true)
                                    let id = index.id
                                    
                                    let request = UNNotificationRequest(identifier: id!.uuidString, content: content, trigger: trigger)
                                    
                                    UNUserNotificationCenter.current().add(request)
                                }
                                try? moc.save()
                            }))
                        }
                        .listRowBackground(Color.clear)
                    }
                }
                .onDelete(perform: deleteNotifs)
                .listRowBackground(Color.clear)
            }
            .scrollContentBackground(.hidden)
            .padding()
            .listRowBackground(Color.clear)

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
                        if (!notifs.isEmpty && notifs.endIndex > 1) {
                            let toDelete = notifs.last?.id?.uuidString
                            UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: [toDelete!])
                            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [toDelete!])
                            moc.delete(notifs[notifs.endIndex - 1])
                            
                            try? moc.save()
                        }
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
            /*
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
             */

        }
    }
    
    private func deleteNotifs(at offsets: IndexSet) {
        for offset in offsets {
            let notif = notifs[offset]
            moc.delete(notif)
        }
        
        try? moc.save()
    }
    
    private func makeDefaultNotifs() {
        if (notifs.isEmpty) {
            let notification = Notifications(context: moc)
            notification.id = UUID()
            notification.title = "Click here to take your measurement!"
            notification.isOn = true
            notification.time = Date.now
            
            do {
                try moc.save()
            } catch {
                print("error")
            }
            
            let content = UNMutableNotificationContent()
            content.title = "APTBiosensor"
            content.subtitle = notification.title!
            content.sound = UNNotificationSound.default
            
            let dateComp = Calendar.current.dateComponents([.hour, .minute], from: notification.time!)
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComp, repeats: true)
            let id = notification.id
            
            let request = UNNotificationRequest(identifier: id!.uuidString, content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request)
        }
    }
}
