//
//  ProjectView.swift
//  BioSensor
//
//  Created by Rivera Torres, Patria I. on 2/15/23.
//

import Foundation
import SwiftUI
import CoreMotion
import FirebaseAuth
import GoogleSignIn

struct ProfileView: View {
    @State private var currentDate = Date.now
    
    var name: String = GIDSignIn.sharedInstance.currentUser?.profile?.name ?? ""
    var profileImage = GIDSignIn.sharedInstance.currentUser?.profile?.imageURL(withDimension: 150)
    @State private var confirmationShown = false
    
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 0.50, green: 0.82, blue: 0.96)
                    .edgesIgnoringSafeArea(.all)
                
                VStack{
                    VStack {
                        AsyncImage(url: profileImage)
                            .frame(width: 150, height: 150)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 4))
                            .foregroundColor(Color(red: 0.98, green: 0.69, blue: 0.27))
                        
                        Text(name)
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .shadow(radius: 1)
                        
                        //                        Text(username)
                        //                            .font(.subheadline)
                        //                            .foregroundColor(.gray)
                        
                        NavigationLink(destination: Notification()){
                            Text("REMINDERS")
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .font(.system(size: 20)
                                    .bold())
                                .padding()
                                .foregroundColor(Color(red: 0.98, green: 0.69, blue: 0.27))
                                .background(.white)
                            
                        }
                        .cornerRadius(10)
                        .padding()
                        .shadow(radius: 2)
                        
                        NavigationLink(destination: ResourcesView()){
                            Text("RESOURCES")
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .font(.system(size: 20)
                                    .bold())
                                .padding()
                                .foregroundColor(Color(red: 0.98, green: 0.69, blue: 0.27))
                                .background(.white)
                        }
                        .cornerRadius(10)
                        .padding()
                        .shadow(radius: 2)
                        
                        NavigationLink(destination: AboutView()){
                            Text("ABOUT")
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .font(.system(size: 20)
                                    .bold())
                                .padding()
                                .foregroundColor(Color(red: 0.98, green: 0.69, blue: 0.27))
                                .background(.white)
                        }
                        .cornerRadius(10)
                        .padding()
                        .shadow(radius: 2)

                        Button(
                            role: .destructive,
                            action: {
                                confirmationShown = true
                            }) {
                                Text("SIGN OUT")
                                    .frame(minWidth: 0, maxWidth: .infinity)
                                    .font(.system(size: 20)
                                        .bold())
                                    .padding()
                                    .foregroundColor(Color(red: 0.98, green: 0.69, blue: 0.27))
                                    .background(.white)
                            }
                            .cornerRadius(10)
                            .padding()
                            .shadow(radius: 2)
                            .confirmationDialog(
                                "Are you sure you want to sign out?",
                                isPresented: $confirmationShown,
                                titleVisibility: .visible
                            ) {
                                Button("Sign Out", role: .destructive) {
                                    let firebaseAuth = Auth.auth()
                                    do {
                                        try firebaseAuth.signOut()
                                    } catch let signOutError as NSError {
                                        print("Error signing out: %@", signOutError)
                                    }
                                    UserDefaults.standard.set(false, forKey: "signedIn")
                                }
                            }
                    }
                    .padding()
                    .frame(maxHeight: .infinity)
                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
