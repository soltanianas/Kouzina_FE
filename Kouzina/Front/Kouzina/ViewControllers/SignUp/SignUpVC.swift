//
//  SignUpVC.swift
//  Kouzina
//
//  Created by Anil Dhameliya on 21/11/21.
//

import UIKit

class SignUpVC: UIViewController {
    
    
    @IBOutlet weak var nomTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var mdpTF: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnSIgnUpClicked(_ sender: Any) {
        
        let user = User(
            nom: nomTF.text,
            email: emailTF.text,
            password: mdpTF.text
        )
        
        UserViewModel().inscription(user: user) { success in
            if success {
                self.present(Alert.makeSingleActionAlert(titre: "Notice", message: "Inscription effectué avec succés", action: UIAlertAction(title: "Connexion", style: .default, handler: { UIAlertAction in
                    self.performSegue(withIdentifier: "connexionSegue", sender: nil)
                })),animated: true)
            } else {
                self.present(Alert.makeAlert(titre: "Erreur", message: "Inscription echouée"), animated: true, completion: nil)
            }
        }
    }
}
