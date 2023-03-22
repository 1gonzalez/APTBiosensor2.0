//
//  BioSensorApp.swift
//  BioSensor
//
//  Created by Shi Xiang Lim on 1/21/23.
//

import SwiftUI
import Firebase
import UserNotifications

@main
struct BioSensorApp: App {
    let persistenceController = PersistenceController.shared
    @AppStorage("signedIn") var isSignedIn = false
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
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
            if !isSignedIn{
                SignInView()
            } else {
                ContentView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
        }
    }
}
