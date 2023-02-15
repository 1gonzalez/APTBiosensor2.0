//
//  ContentView.swift
//  BioSensor
//
//  Created by Shi Xiang Lim on 1/21/23.
//

import SwiftUI
import CoreMotion


struct ContentView: View {
    
    let largeConfig = UIImage.SymbolConfiguration(pointSize: 140, weight: .bold, scale: .large)

    @State private var readings =        [
        Reading(
            date:"01/02/03",
            interval:"Test"
        )
        ]
    
    @State private var tabSelection = 2
    @State private var buttonPressed = 0
    @State private var currentDate = Date.now
    @State private var textInput = ""
    var body: some View {
        TabView (selection: $tabSelection){
            Measurement(currentDate:$currentDate,
                        reading:$readings, textInput:$textInput)
            .tabItem {
                Label("Data", systemImage: "chart.xyaxis.line")
            }
            .tag(1)
            
            MainMenu(tabSelection: $tabSelection)
                .tabItem {
                    Label("Measure", systemImage: "bolt.heart")
                }
                .tag(2)
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
                .tag(3)
        }
    }
}

struct Reading: Identifiable {
    let date: String
    let interval:String
    let id = UUID()
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
