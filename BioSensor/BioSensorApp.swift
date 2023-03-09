//
//  BioSensorApp.swift
//  BioSensor
//
//  Created by Shi Xiang Lim on 1/21/23.
//

import SwiftUI
import UserNotifications

@main
struct BioSensorApp: App {
    //@StateObject private var dataController = DataController()
    let persistenceController = PersistenceController.shared
    let center = UNUserNotificationCenter.current()
    
    init() {
        center.requestAuthorization(options: [.badge, .sound, .alert], completionHandler: {granted, error in
            if granted {
                print("Woah it worked")
            }
            if let error = error {
                print(error.localizedDescription)
            }
        })
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                //.environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
