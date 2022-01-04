//
//  ConfirmationView.swift
//  Chicky
//
//  Created by Jamel & Maher on 27/11/2021.
//

import UIKit

class ConfirmationView: UIViewController {
    
    // VAR
    var data : MdpOublieView.MotDePasseOublieData?
    
    // WIDGET
    @IBOutlet weak var codeTextField: UITextField!
    @IBOutlet weak var buttonSend: UIButton!
    
    // PROTOCOLS
    
    // LIFECYCLE
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! ChangerMdpView
        destination.email = data?.email
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // METHODS

    // ACTIONS
    @IBAction func suivant(_ sender: Any) {
        
        if (codeTextField.text!.isEmpty){
            self.present(Alert.makeAlert(titre: "Avertissement", message: "Veuillez taper le code"), animated: true)
            return
        }
        
        if (codeTextField.text == data?.code ) {
            self.performSegue(withIdentifier: "changerMdpSegue", sender: data?.email)
        } else {
            self.present(Alert.makeAlert(titre: "Erreur", message: "Code incorrect"), animated: true)
        }
    }
    
}
