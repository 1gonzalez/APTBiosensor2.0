//
//  NewNotification.swift
//  BioSensor
//
//  Created by Rivera Torres, Patria I. on 4/3/23.
//

import SwiftUI
import UserNotifications

struct NewNotification: View {
    @State private var label:String = ""
    @State private var date = Date.now
    let content = UNMutableNotificationContent()
    @Environment(\.managedObjectContext) var moc
    
    
    var body: some View {
        ZStack{
            Color(red: 0.50, green: 0.82, blue: 0.96).edgesIgnoringSafeArea(.all)
            VStack{
                Text("Make Your Reminder!")
                    .font(.title)
                    .bold()
                    .foregroundColor(Color(red: 0.98, green: 0.69, blue: 0.27))
                Spacer()
                DatePicker("Notification Date", selection: $date, displayedComponents: .hourAndMinute)
                TextField("Pick a label for your notification", text: $label)
                    .onSubmit {
                        let content = UNMutableNotificationContent()
                        content.title = "APTBiosensor"
                        content.subtitle = label
                        content.sound = UNNotificationSound.default
                        
                        let dateComp = Calendar.current.dateComponents([.hour, .minute], from: date)
                        
                        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComp, repeats: true)
                        let id = UUID()
                        
                        let request = UNNotificationRequest(identifier: id.uuidString, content: content, trigger: trigger)
                        
                        UNUserNotificationCenter.current().add(request)
                        
                        let notif = Notifications(context: moc)
                        notif.id = id
                        notif.time = Calendar.current.date(from: dateComp)
                        notif.title = label
                        notif.isOn = true
                        do{
                            try moc.save()
                        }
                        catch{
                            print("error")
                        }
                    }
                    .frame(alignment: .center)
                Spacer()
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
