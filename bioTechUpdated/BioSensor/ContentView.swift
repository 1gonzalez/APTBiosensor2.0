//
//  ContentView.swift
//  BioSensor
//
//  Created by Shi Xiang Lim on 1/21/23.
//

import SwiftUI
import CoreMotion
import Firebase
import GoogleSignIn


struct ContentView: View {
    
    let largeConfig = UIImage.SymbolConfiguration(pointSize: 140, weight: .bold, scale: .large)
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor(Color.white.opacity(0.2))
        UITabBar.appearance().unselectedItemTintColor = .white
        UITabBar.appearance().tintColor = UIColor(Color.white.opacity(0.2))
        UITabBar.appearance().barTintColor = UIColor(Color(red: 0.53, green: 0.84, blue: 0.95))
      }
    
    

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
        ZStack{
            Color(red: 0.50, green: 0.82, blue: 0.96).edgesIgnoringSafeArea(.all)
            TabView (selection: $tabSelection){
                Measurement()
    
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
            .accentColor(Color.accentColor)
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
