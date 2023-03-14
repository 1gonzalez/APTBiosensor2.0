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
            Color(red: 0.50, green: 0.82, blue: 0.96).edgesIgnoringSafeArea(.all)
            VStack {
                
                Image(systemName: "minus")

                    .font(.system(size: 60))
                    .padding(.bottom)
                
                Text("Quick Start Guide")
                    .font(.largeTitle)
                    .underline()
                    .padding()
                    .foregroundColor(Color.accentColor)
                
                Text("Ensure device is positioned on your right leg 10 cm below your pelvic bone \n \nThe screen should be facing away from your leg pointed down towards the front of the knee \n \nAlways use the same position every time you take a measurement")
                    .font(.title3)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.leading)
                    .padding()
                    .fixedSize(horizontal:false, vertical:true)
                
                Image("APTGuide")
                    .resizable()
                    .scaledToFit()
                    .padding()
            }
            .padding()
            //.frame(width: UIScreen.main.bounds.width*3/4, height: UIScreen.main.bounds.height*3/4)
        }
    }
}


struct QuickStart_Previews: PreviewProvider {
    static var previews: some View {
        QuickStartGuideView()
    }
}
