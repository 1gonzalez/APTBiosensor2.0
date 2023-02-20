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
                    DataController().createTilt(pitch:15.23,dateTime:Date.now)
                }
                Text(String(DataController().fetchTilt().count))
            }
            .frame(width: UIScreen.main.bounds.width*3/4, height: UIScreen.main.bounds.height*3/4)
        }
    }
}
