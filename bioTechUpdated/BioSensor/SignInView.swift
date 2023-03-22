//
//  SignInView.swift
//  BioSensor
//
//  Created by Juan on 3/1/23.
//

import Foundation
import SwiftUI

struct SignInView: View {
    var body: some View {
        ZStack{
            Color(red: 0.50, green: 0.82, blue: 0.96).edgesIgnoringSafeArea(.all)
            VStack {
                
                Image("Logo_Letters")
                    .resizable()
                    .scaledToFit()
                    .padding()
                }
                
                Spacer()
            }
        }
    }

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
