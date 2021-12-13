//
//  SignInVC.swift
//  Kouzina
//
//  Created by Anas Soltani on 21/11/21.
//

import UIKit
//import GoogleSignIn

class SignInVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        GIDSignIn.sharedInstance().delegate = self
//        // 3
//        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
        // Do any additional setup after loading the view.
    }


    @IBAction func btnSIgnUpClicked(_ sender: Any) {
        let obj = AppStoryboard.Main.instance.instantiateViewController(withIdentifier: "SignUpVC") as! SignUpVC
        self.navigationController?.pushViewController(obj, animated: true)
    }
    
    
    @IBAction func btnGoogleClicked(_ sender: Any) {
//        GIDSignIn.sharedInstance()?.signIn()
    }
    
    @IBAction func btnFacebookClicked(_ sender: Any) {
        
    }

}
//
//extension SignInVC: GIDSignInDelegate {
//
//    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
//
//        // Check for sign in error
//        if let error = error {
//            if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
//                print("The user has not signed in before or they have since signed out.")
//            } else {
//                print("\(error.localizedDescription)")
//            }
//            return
//        }
//
//        // Post notification after user successfully sign in
//        NotificationCenter.default.post(name: .signInGoogleCompleted, object: nil)
//    }
//}
//
//// MARK:- Notification names
//extension Notification.Name {
//
//    /// Notification when user successfully sign in using Google
//    static var signInGoogleCompleted: Notification.Name {
//        return .init(rawValue: #function)
//    }
//}
