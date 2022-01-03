//
//  SignInVC.swift
//  Kouzina
//
//  Created by Anil Dhameliya on 21/11/21.
//

import UIKit
import GoogleSignIn
//import FBSDKLoginKit
import LocalAuthentication
import UserNotifications

class SignInVC: UIViewController {
    
    
    let signInConfig = GIDConfiguration.init(clientID: "148466381615-mpc55dgfkrqk7q97dbuisl31br5kjhbj.apps.googleusercontent.com")
    
    //let facebookLoginButton = FBLoginButton(frame: .zero, permissions: [.publicProfile,.email])
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var mdpTF: UITextField!
    
    @IBOutlet weak var facebookCustomView: CustomView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
       
  
        //facebookLoginButton.frame = CGRect(x: 5, y: 5, width: facebookCustomView.frame.width - 10, height: facebookCustomView.frame.height - 10)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let window = UIApplication.shared.keyWindow
        if #available(iOS 13.0, *) {
            window?.overrideUserInterfaceStyle = .dark
        }
        
        
    }
    
    //func loginWithFacebook() {
        //let imageData = NSData()
        
        //GraphRequest(graphPath: "me", parameters: ["fields": "first_name,last_name,  picture.width(480).height(480),email, id"]).start { [self] (connection, result, error) in
            //
           // debugPrint(error)
            
            //if let fields = result as? [String:Any],
             //  let lastname = fields["last_name"] as? String,
               //let firstName = fields["first_name"] as? String,
               //let email = fields["email"] as? String,
               //let id = fields["id"] as? String {
                
                //if let profilePictureObj = fields["picture"] as? NSDictionary{
                
                //let data = profilePictureObj["data"] as! NSDictionary
                //let pictureUrlString  = data["url"] as! String
                //let pictureUrl = NSURL(string: pictureUrlString)
                
                //let imageData = NSData(contentsOf: pictureUrl! as URL)
                //let newImage = UIImage(data: imageData as! Data)
                
                //}
                
               
    
    //@objc func facebookSignIn(_ loginButton: FBLoginButton,
    //}
    
    @IBAction func btnSIgnUpClicked(_ sender: Any) {
        
    }
    @IBAction func sender(_ sender: Any) {
    
        
        let center = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = "bienvenu chez kouzina "
        content.body = "on va resoudre votre probléme au plus tot possible"
        content.sound = .default
        content.userInfo = ["value": "Data with local notification"]
        
        
        let fireDate = Calendar.current.dateComponents([.day, .month, .year, .hour, .minute, .second], from: Date().addingTimeInterval(10))
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: fireDate, repeats: false)
        //UNTimeIntervalNotificationTrigger(timeInterval: 20, repeats: false)
        
        let request = UNNotificationRequest(identifier: "reminder", content: content, trigger: trigger)
        center.add(request) { (error) in
            if error != nil {
                print("Error = \(error?.localizedDescription ?? "error local notification")")
            }
        }
        
    }
    
    
    @IBAction func btnGoogleClicked(_ sender: Any) {
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self) { [self] user, error in
            guard error == nil else { return }
            guard let user = user else { return }
            
            let email = user.profile?.email
            let name = (user.profile?.givenName)! + " " + (user.profile?.familyName)!
            
            
            
            UserViewModel.sharedInstance.loginWithSocial(email:email! , nom: name, completed: { success, user in
                if success {
                    appDelegate.moveToTabbar()
                } else {
                    self.present(Alert.makeAlert(titre: "Error", message: "Could not login with social media"), animated: true)
                }
                
            })
        }
    }
    
    @IBAction func btnFacebookClicked(_ sender: Any) {
        
    }
    
    @IBAction func btnConnexion(_ sender: Any) {
        
        
        UserViewModel.sharedInstance.login(email: emailTF.text!, mdp: mdpTF.text!) { success, user in
            if success {
                appDelegate.moveToTabbar()
            } else {
                self.present(Alert.makeAlert(titre: "Erreur", message: "Mot de passe ou email incorrect"), animated: true, completion: nil)
            }
        }
        
    }
    
    
    @IBAction func faceId(_ sender: Any) {
        let localString = "Biometric Authentication"
        let context = LAContext()
           var error: NSError?

           if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
               let reason = "Identify yourself!"

               context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                   [weak self] success, authenticationError in

                   DispatchQueue.main.async {
                       if success {
                           appDelegate.moveToTabbar()

                       } else {
                           // error
                       }
                   }
               }
           } else {
               // no biometry
    }
    }
    
    
    func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)

        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)

            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }

        return nil
    }

    //let image = generateQRCode(from: "Hacking with Swift is the best iOS coding tutorial I've ever read!")
    
    
    
   
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
