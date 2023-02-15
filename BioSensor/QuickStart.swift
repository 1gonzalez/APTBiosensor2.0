//
//  QuickStartGuide.swift
//  BioSensor
//
//  Created by Shi Xiang Lim on 2/7/23.
//

import Foundation
import SwiftUI

struct QuickStartGuideView: View {
    var body: some View {
        ZStack{
            Color.teal.edgesIgnoringSafeArea([.top])
            VStack {
                Text("This is our qsg")
                    .font(.title)
                    .fontWeight(.bold)
            }
            .frame(width: UIScreen.main.bounds.width*3/4, height: UIScreen.main.bounds.height*3/4)
        }
    }
}
