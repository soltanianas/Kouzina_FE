//
//  MenuView.swift
//  Kouzina
//
//  Created by Apple Esprit on 12/12/2021.
//

import Foundation
import UIKit

class MenuView: UIViewController {
    
    @IBOutlet weak var ajouterPlatsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ajouterPlatsButton.isHidden = true
        
        if UserDefaults.standard.string(forKey: "userRole") == "admin" {
            ajouterPlatsButton.isHidden = false
        }
    }
    
}
