//
//  GoogleSignInButton.swift
//  BioSensor
//
//  Created by Juan on 3/1/23.
//

import SwiftUI
import GoogleSignIn

struct GoogleSignInButton: View {
    
    var action: () -> Void
    
    var body: some View {
        
        Button(action: {
            action()
        }) {
            HStack {
                Image("Google_Logo")
                    .resizable()
                    .frame(width: 35 , height: 35)
                Text("Sign in with Google")
                    .foregroundColor(Color(red: 0.98, green: 0.69, blue: 0.27))
                    .font(
                        .system(size: 20)
                        .bold())
            }
            .padding(.vertical, 10)
            .frame(minWidth: 0, maxWidth: .infinity)
            .background(Color(red: 0.82, green: 0.88, blue: 0.92))
        }
        .cornerRadius(10)
        .padding(50)
        
    }
}


struct GoogleSignInButton_Previews: PreviewProvider {
    static var previews: some View {
        GoogleSignInButton(action: {})
    }
    
}
