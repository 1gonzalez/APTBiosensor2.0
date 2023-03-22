//
//  BioSensorApp.swift
//  BioSensor
//
//  Created by Shi Xiang Lim on 1/21/23.
//

import SwiftUI
import Firebase

@main
struct BioSensorApp: App {
    let persistenceController = PersistenceController.shared
    @AppStorage("signedIn") var isSignedIn = false
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
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
