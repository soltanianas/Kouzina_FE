//
//  AddOrderView.swift
//  Kouzina
//
//  Created by Apple Esprit on 12/12/2021.
//

import Foundation
import UIKit

class AddOrderView: UIViewController {
    
    // VAR
    var currentPhoto : UIImage?
    var plat : Plat?
    
    // WIDGET
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var emplacementTextField: UITextField!
    @IBOutlet weak var platLabel: UILabel!
    
    // PROTOCOLS
    
    // LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        platLabel.text = plat?.description
    }
    
    // METHODS
    
    // ACTIONS
    @IBAction func ajouterOrder(_ sender: Any) {
        
        let order = Order(
            type: typeTextField.text!,
            emplacement: emplacementTextField.text!,
            plat: plat
        )
        
        OrderViewModel.sharedInstance.add(order: order) { success in
            if success {
                self.present(Alert.makeSingleActionAlert(titre: "Success", message: "Order added",action: UIAlertAction(title: "Proceed", style: .default, handler: { UIAlertAction in
                    self.dismiss(animated: true, completion: nil)
                })),animated: true)
            }
        }
    }
}
