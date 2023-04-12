//
//  ChangeNotif.swift
//  BioSensor
//
//  Created by Rivera Torres, Patria I. on 4/12/23.
//

import SwiftUI


struct ChangeNotification: View {
    let notification: Notifications
    @State var label:String = ""
    @State var date:Date = Date.now
    @Environment(\.managedObjectContext) var moc
    
    var body: some View {
        ZStack {
            Color(red: 0.50, green: 0.82, blue: 0.96).edgesIgnoringSafeArea(.all)
            VStack {
                Text("Change Your Reminder")
                    .font(.title)
                    .foregroundColor(Color(red: 0.98, green: 0.69, blue: 0.27))
                    .bold()
                Spacer()
                Text("Would you like to change your reminder title?")
                    .onAppear {
                        date = notification.time!
                        label = notification.title!
                    }
                TextField(notification.title!, text: $label)
                    .font(.title3)
                    .frame(alignment: .center)
                    .background(Color(red: 0.82, green: 0.88, blue: 0.92))
                Text("Choose your time")
                    .font(.title2)
                    .frame(alignment: .leading)
                DatePicker("", selection: $date, displayedComponents: .hourAndMinute)
                    .datePickerStyle(.wheel)
                    .labelsHidden()
                Button("Save", action: {
                    notification.title = label
                    notification.time = date
                    
                    let toDelete = notification.id?.uuidString
                    UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: [toDelete!])
                    UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [toDelete!])
                    
                    if (notification.isOn) {
                        let content = UNMutableNotificationContent()
                        content.title = "APTBiosensor"
                        content.subtitle = label
                        content.sound = UNNotificationSound.default
                        
                        let dateComp = Calendar.current.dateComponents([.hour, .minute], from: date)
                        
                        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComp, repeats: true)
                        let id = notification.id!
                        
                        let request = UNNotificationRequest(identifier: id.uuidString, content: content, trigger: trigger)
                        
                        UNUserNotificationCenter.current().add(request)
                    }
                    
                    do{
                        try moc.save()
                    }
                    catch{
                        print("error")
                    }
                })
                .frame(alignment: .bottomTrailing)
                Spacer()
            }
        }
    }
}

/*
 struct ChangeNotif_Previews: PreviewProvider {
 static var previews: some View {
 ChangeNotif()
 }
 }
 */
