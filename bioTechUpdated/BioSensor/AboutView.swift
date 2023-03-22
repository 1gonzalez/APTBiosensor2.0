//
//  AboutView.swift
//  BioSensor
//
//  Created by Juan on 3/13/23.
//

//
//  QuickStartGuide.swift
//  BioSensor
//
//  Created by Shi Xiang Lim on 2/7/23.
//

import Foundation
import SwiftUI

struct AboutView: View {
    var body: some View {
        ZStack{
            Color(red: 0.50, green: 0.82, blue: 0.96).edgesIgnoringSafeArea(.all)
            VStack {
//                Text("About")
//                    .font(.largeTitle)
//                    .padding()
//                    .foregroundColor(Color.accentColor)
                
                Image("Logo_Letters")
                    .resizable()
                    .scaledToFit()
                    .padding()
            
                
                Text("APT BioSensor is an application designed to allow anyone to measure and track their pelvic tilt. \n \nExtreme anterior pelvic tilt is commonly found alongside lumbar & pelvic pain, but has yet to be cited as a cause of it.\n \nThis makes APT BioSensor the first application that collects this data for personal use.")
                    .font(.title3)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal:false, vertical:true)
                    .padding()
                
                Text("Developers:")
                    .multilineTextAlignment(.center)
                    .underline()
                    .fontWeight(.medium)
                    .padding(.top)
                Text("\nShi Xiang Lim \nPatria I. Rivera Torres \nJuan J. Gonzalez")
                    .multilineTextAlignment(.center)
                    .padding(.bottom)
                Spacer()
                
                
            }
            .padding()
            //.frame(width: UIScreen.main.bounds.width*3/4, height: UIScreen.main.bounds.height*3/4)
        }
    }
}


struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
