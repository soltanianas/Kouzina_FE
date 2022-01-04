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
    @IBOutlet weak var ajouterChefButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ajouterPlatsButton.isHidden = true
        ajouterChefButton.isHidden = true
        
        if UserDefaults.standard.string(forKey: "userRole") == "admin" {
            ajouterPlatsButton.isHidden = false
            ajouterChefButton.isHidden = false
        }
    }
    
    @IBAction func chefs(_ sender: Any) {
        let obj = AppStoryboard.Main.instance.instantiateViewController(withIdentifier: "FilterVC") as! FilterVC
        obj.hidesBottomBarWhenPushed = false
        self.navigationController?.pushViewController(obj, animated: true)
    }
    
}
