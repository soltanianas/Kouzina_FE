//
//  PlatsVC.swift
//  Kouzina
//
//  Created by Anil Dhameliya on 21/11/21.
//

import UIKit
import FittedSheets

class OrdersVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // VARIABLES
    var plats : [Plat] = []
    
    // WIDGETS
    @IBOutlet weak var tableview: UITableView!
    
    // PROTOCOLS
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return plats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "mCell")
        let contentView = cell?.contentView
        
        let platImage = contentView?.viewWithTag(1) as! UIImageView
        let descPlat = contentView?.viewWithTag(2) as! UILabel
        let compoPlat = contentView?.viewWithTag(3) as! UILabel
        let PrixPlat = contentView?.viewWithTag(4) as! UILabel
        
        let plat = plats[indexPath.row]
        
        if (plat.image != nil) {
            if plat.image != ""{
                ImageLoader.shared.loadImage(
                    identifier: plat.image!,
                    url: "http://localhost:3000/img/" + plat.image!,
                    completion: { image in
                        platImage.image = image
                    })
            }
        }
        
        descPlat.text = plat.description
        compoPlat.text = plat.composition
        PrixPlat.text = String(plat.prix)
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "favSegue", sender: indexPath)
    }
    
    // LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        PlatViewModel.sharedInstance.getAll { [self] success, platsFromRep in
            if success {
                plats = []
                for plat in platsFromRep! {
                    if UserDefaults.standard.array(forKey: "favoriteFood") != nil {

                        let favoritesArray = UserDefaults.standard.array(forKey: "favoriteFood") as! [String]
                        if favoritesArray.contains(plat._id!){
                            plats.append(plat)
                        }
                    }
                    print(UserDefaults.standard.array(forKey: "favoriteFood"))
                }
                
                self.tableview.reloadData()
            }else {
                self.present(Alert.makeAlert(titre: "Error", message: "Could not load formations "),animated: true)
            }
        }
    }
    
    // METHODS
}
