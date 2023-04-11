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

struct ProfileView: View {
    @State private var currentDate = Date.now
    
    var name: String = "Albert Gator"
    var username: String = "A.Gator352"
    var profileImage: Image = Image(systemName: "person.fill")
    @State private var confirmationShown = false
    
    
    var body: some View {
        NavigationView {
            
            ZStack {
                Color(red: 0.50, green: 0.82, blue: 0.96).edgesIgnoringSafeArea(.all)
                
                VStack{
                    VStack {
                        profileImage
                            .resizable()
                            .frame(width: 150, height: 150)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 4))
                            .shadow(radius: 10)
                            .foregroundColor(.accentColor)
                        
                        Text(name)
                            .font(.title)
                            .bold()
                            .foregroundColor(.accentColor)
                        
                        //                        Text(username)
                        //                            .font(.subheadline)
                        //                            .foregroundColor(.gray)
                        
                        NavigationLink(destination: Notification()){
                            Text("REMINDERS")
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .font(.system(size: 18)
                                    .bold())
                                .padding()
                                .foregroundColor(.accentColor)
                                .background(Color(red: 0.82, green: 0.88, blue: 0.92))
                        }
                        .cornerRadius(10)
                        .padding()
                        
                        Button(action: {
                            print("Resources was tapped")
                        }) {
                            Text("RESOURCES")
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .font(.system(size: 18)
                                    .bold())
                                .padding()
                                .foregroundColor(.accentColor)
                                .background(Color(red: 0.82, green: 0.88, blue: 0.92))
                        }
                        .cornerRadius(10)
                        .padding()
                        
                        NavigationLink(destination: AboutView()){
                            Text("ABOUT")
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .font(.system(size: 18)
                                    .bold())
                                .padding()
                                .foregroundColor(.accentColor)
                                .background(Color(red: 0.82, green: 0.88, blue: 0.92))
                        }
                        .cornerRadius(10)
                        .padding()
                        
                        //                        Button(action: {
                        //                            print("About was tapped")
                        //                        }) {
                        //                            Text("ABOUT")
                        //                                .frame(minWidth: 0, maxWidth: .infinity)
                        //                                .font(.system(size: 18)
                        //                                    .bold())
                        //                                .padding()
                        //                                .foregroundColor(.accentColor)
                        //                                .background(Color(red: 0.82, green: 0.88, blue: 0.92))
                        //                        }
                        //                        .cornerRadius(10)
                        //                        .padding()
                        
                        Button(
                            role: .destructive,
                            action: {
                                confirmationShown = true
                            }) {
                                Text("SIGN OUT")
                                    .frame(minWidth: 0, maxWidth: .infinity)
                                    .font(.system(size: 18)
                                        .bold())
                                    .padding()
                                    .foregroundColor(.accentColor)
                                    .background(Color(red: 0.82, green: 0.88, blue: 0.92))
                            }
                            .cornerRadius(10)
                            .padding()
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
