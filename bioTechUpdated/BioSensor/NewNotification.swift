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
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    
    var body: some View {
        ZStack{
            Color(red: 0.50, green: 0.82, blue: 0.96).edgesIgnoringSafeArea(.all)
            VStack{
                Text("Add New Reminder")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .shadow(radius: 1)
                    .padding(.top)
                Spacer()
                
                Text("Reminder Time")
                    .font(.title2)
                    .foregroundColor(.white)
                    .shadow(radius: 0.5)
                    .padding(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                DatePicker("", selection: $date, displayedComponents: .hourAndMinute)
                    .datePickerStyle(.wheel)
                    .labelsHidden()
                    .colorInvert()
                    .colorMultiply(.white)
                    .padding(.bottom)
                
                Text("Reminder Title")
                    .font(.title2)
                    .foregroundColor(.white)
                    .shadow(radius: 0.5)
                    .padding(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                TextField("", text: $label)
                    .font(.title2)
                    .frame(maxWidth: .infinity, maxHeight: 40, alignment: .center)
                    .background(.white)
                    .foregroundColor(Color(red: 0.13, green: 0.63, blue: 0.85))
                    .multilineTextAlignment(.center)
                    .cornerRadius(10)
                    .padding(.bottom)
                
                Button("Save") {
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
                    self.mode.wrappedValue.dismiss()
                }
                .lineLimit(1)
                .fixedSize()
                .font(.system(size: 18))
                .padding(12)
                .foregroundColor(.white)
                .background(Color.accentColor)
                .cornerRadius(10)
                .shadow(radius: 2)
                    //.padding()
                    //.frame(alignment: .center)
                
                Spacer()
                Spacer()
            }
            .padding()
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
