import Foundation
import SwiftUI
import GoogleSignIn
import GoogleSignInSwift
import Firebase
import FirebaseAuth

struct SignInView: View {
    var body: some View {
        ZStack{
            Color(red: 0.50, green: 0.82, blue: 0.96).edgesIgnoringSafeArea(.all)
            VStack {
                
                Image("Logo_Letters")
                    .resizable()
                    .scaledToFit()
                    .padding()
                
                GoogleSignInButton{
                    UserAuth.share.googleSignIn(presenting: getRootViewController()) { error in print("Error: \(String(describing: error))")
                    }
                }
                
                Spacer()
            }
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
