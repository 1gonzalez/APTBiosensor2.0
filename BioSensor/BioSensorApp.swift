//
//  BioSensorApp.swift
//  BioSensor
//
//  Created by Shi Xiang Lim on 1/21/23.
//

import SwiftUI

@main
struct BioSensorApp: App {
    //@StateObject private var dataController = DataController()
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                //.environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
