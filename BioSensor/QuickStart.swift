//
//  QuickStartGuide.swift
//  BioSensor
//
//  Created by Shi Xiang Lim on 2/7/23.
//

import Foundation
import SwiftUI
import CoreData

struct QuickStartGuideView: View {
    @Environment(\.managedObjectContext) var moc
    
    var body: some View {
        ZStack{
            Color.teal.edgesIgnoringSafeArea([.top])
            VStack {
                Text("This is our qsg")
                    .font(.title)
                    .fontWeight(.bold)
                Button("TestDB"){
                    addItem()
                }
                Text(String(DataController().fetchTilt().count))
            }
            .frame(width: UIScreen.main.bounds.width*3/4, height: UIScreen.main.bounds.height*3/4)
        }
    }
    
    private func addItem() {
        withAnimation {
            let newItem = Tilt(context: moc)
            newItem.dateTime = Date()
            newItem.pitch = 22.3
            newItem.id = UUID()
            
            do {
                try moc.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                print(nsError)
                //fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}
