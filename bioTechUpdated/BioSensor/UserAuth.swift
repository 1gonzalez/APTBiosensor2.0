//
//  UserAuth.swift
//  BioSensor
//
//  Created by Juan on 3/6/23.
//

import Foundation
import FirebaseAuth
import GoogleSignIn
import Firebase

struct UserAuth {
    static let share = UserAuth()
    
    private init() { }
    
    func googleSignIn(presenting: UIViewController, completion: @escaping(Error?) -> Void) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(withPresenting: presenting) { result, error in
            guard error == nil else {
                completion(error)
                return
            }
            
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString
            else {
                return
            }
            
            let fullName = user.profile?.name
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: user.accessToken.tokenString)
            
            // ...
            Auth.auth().signIn(with: credential) { result, error in
                guard error == nil else {
                    completion(error)
                    
                    return
                }
                print("Successful Sign In")
                UserDefaults.standard.set(true, forKey: "signedIn")
            }
        }
        
    }
    
    
}
