//
//  NewNotification.swift
//  BioSensor
//
//  Created by Rivera Torres, Patria I. on 4/3/23.
//

import SwiftUI
import UserNotifications

struct NewNotification: View {
    @State private var date = Date()
    @State private var label:String = ""
    let content = UNMutableNotificationContent()
    @Environment(\.managedObjectContext) var moc
    
    
    var body: some View {
        ZStack{
            //https://www.hackingwithswift.com/forums/swiftui/will-this-notification-fire-each-day/17894 check this for adding a notification once per day
            Color(red: 0.50, green: 0.82, blue: 0.96).edgesIgnoringSafeArea(.all)
            VStack{
                DatePicker("Notification Date", selection: $date, displayedComponents: .hourAndMinute)
                TextField("Pick a label for your notification", text: $label)
                    .onSubmit {
                        let content = UNMutableNotificationContent()
                        content.title = "APTBiosensor"
                        content.subtitle = label
                        content.sound = UNNotificationSound.default
                        
                        let dateComp = Calendar.current.dateComponents([.hour, .minute], from: date)
                        
                        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComp, repeats: true)
                        
                        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                        
                        UNUserNotificationCenter.current().add(request)
                    }
            }
        }
        
    }
}

struct NewNotification_Previews: PreviewProvider {
    static var previews: some View {
        NewNotification()
    }
}
