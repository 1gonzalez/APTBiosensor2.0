//
//  NewNotification.swift
//  BioSensor
//
//  Created by Rivera Torres, Patria I. on 4/3/23.
//

import SwiftUI
import UserNotifications

struct NewNotification: View {
    let notification: Notifications
    @State private var label:String = ""
    @State private var date = Date.now
    let content = UNMutableNotificationContent()
    @Environment(\.managedObjectContext) var moc
    
    
    var body: some View {
        ZStack{
            //https://www.hackingwithswift.com/forums/swiftui/will-this-notification-fire-each-day/17894 check this for adding a notification once per day
            Color(red: 0.50, green: 0.82, blue: 0.96).edgesIgnoringSafeArea(.all)
            VStack{
                //label = notification.title ?? ""
                DatePicker("Notification Date", selection: Binding(get: {notification.time ?? date}, set: {_,_ in }), displayedComponents: .hourAndMinute)
                TextField(notification.title ?? "Pick a label for your notification", text: Binding(get: {notification.title ?? label}, set: {_,_ in }))
                    .onSubmit {
                        if (notification.time != nil) {
                            let toDelete = notification.id?.uuidString
                            UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: [toDelete!])
                            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [toDelete!])
                        }
                        let content = UNMutableNotificationContent()
                        content.title = "APTBiosensor"
                        content.subtitle = label
                        content.sound = UNNotificationSound.default
                        
                        let dateComp = Calendar.current.dateComponents([.hour, .minute], from: notification.time ?? date)
                        
                        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComp, repeats: true)
                        let id = notification.id ?? UUID()
                        
                        let request = UNNotificationRequest(identifier: id.uuidString, content: content, trigger: trigger)
                        
                        UNUserNotificationCenter.current().add(request)
                        
                        if (notification.time == nil) {
                            let notif = Notifications(context: moc)
                            notif.id = id
                            notif.time = Calendar.current.date(from: dateComp)
                            notif.title = label
                            notif.isOn = true
                        }
                        else {
                            notification.id = id
                            notification.title = label
                            notification.time = date
                        }
                        do{
                            try moc.save()
                        }
                        catch{
                            print("error")
                        }
                    }
            }
        }
    }
}

/*
 struct NewNotification_Previews: PreviewProvider {
 static var previews: some View {
 NewNotification(Date.now)
 }
 }
 */
