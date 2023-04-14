//
//  ResourcesView.swift
//  BioSensor
//
//  Created by Juan on 4/10/23.
//



import Foundation
import SwiftUI

struct ResourcesView: View {
    var body: some View {
        ZStack{
            Color(red: 0.50, green: 0.82, blue: 0.96).edgesIgnoringSafeArea(.all)
            VStack {
                
                Text("Resources Screen Place Holder")
                    .font(.title3)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal:false, vertical:true)
                    .padding()
                    .foregroundColor(.black)

                Spacer()
                
                
            }
            .padding()
        }
    }
}
