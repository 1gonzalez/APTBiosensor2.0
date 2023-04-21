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
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        ZStack {
            Color(red: 0.50, green: 0.82, blue: 0.96).edgesIgnoringSafeArea(.all)
            VStack {
                Text("Edit Your Reminder")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .shadow(radius: 1)
                    .padding(.top)
                Spacer()
                Text("Reminder Title")
                    .font(.title)
                    .foregroundColor(.white)
                    .shadow(radius: 1)
                    .padding(.top)
                    .onAppear {
                        date = notification.time!
                        label = notification.title!
                    }
                TextField(notification.title!, text: $label)
                    .font(.title3)
                    .frame(maxWidth: .infinity, maxHeight: 40, alignment: .center)
                    .background(.white)
                    .foregroundColor(Color(red: 0.13, green: 0.63, blue: 0.85))
                    .multilineTextAlignment(.center)
                    .cornerRadius(10)
                    .padding(.bottom)
                
                Text("Reminder Time")
                    .font(.title)
                    .shadow(radius: 1)
                    .foregroundColor(.white)
                
                DatePicker("", selection: $date, displayedComponents: .hourAndMinute)
                    .datePickerStyle(.wheel)
                    .labelsHidden()
                    .colorInvert()
                    .colorMultiply(.white)
                    .padding(.bottom)
                
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
                    
                    self.mode.wrappedValue.dismiss()
                })
                .lineLimit(1)
                .fixedSize()
                .font(.system(size: 18))
                .padding(12)
                .foregroundColor(.white)
                .background(Color.accentColor)
                .cornerRadius(10)
                .shadow(radius: 2)
                
                Spacer()
            }
            .padding()
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
