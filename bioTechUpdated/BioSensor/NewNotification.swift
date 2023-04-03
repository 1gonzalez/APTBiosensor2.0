//
//  NewNotification.swift
//  BioSensor
//
//  Created by Rivera Torres, Patria I. on 4/3/23.
//

import SwiftUI

struct NewNotification: View {
    var body: some View {
        ZStack{
            Color(red: 0.50, green: 0.82, blue: 0.96).edgesIgnoringSafeArea(.all)
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
    }
}

struct NewNotification_Previews: PreviewProvider {
    static var previews: some View {
        NewNotification()
    }
}
