//
//  FilterVC.swift
//  Kouzina
//
//  Created by Anil Dhameliya on 21/11/21.
//

import UIKit

class FilterVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    // variables
    var chefs = [Chef]()
    var chefForDetails : Chef?
    
    // iboutlets
    @IBOutlet weak var chefsTableView: UITableView!
    
    // protocols
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        chefs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mCell", for: indexPath)
        let contentView = cell.contentView
        let chefImage = contentView.viewWithTag(1) as! UIImageView
        let chefLabel = contentView.viewWithTag(2) as! UILabel
        
        let chef = chefs[indexPath.row]
        print(chef)
        if chef.image != ""{
            ImageLoader.shared.loadImage(
                identifier: chef.image,
                url: "http://localhost:3000/img/" + chef.image,
                completion: { image in
                    chefImage.image = image
                })
        }
        
        chefLabel.text = chef.nom
        
        return cell
    }
    
    // life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if reachability.connection == .unavailable {
            showSpinner()
            self.showAlert(title: "Connectivity Problem", message: "Please check your internet connection ")
        } else {
            if (UserDefaults.standard.string(forKey: "isItNew")) == "isNew"{
                self.present(Alert.makeAlert(titre: "Bienvenue", message: "Bienvenu " + UserDefaults.standard.string(forKey: "userNom")!), animated: true, completion: nil)
                UserDefaults.standard.set("", forKey: "isItNew")
            }
            loadChefs()}
    }
    
    // methods
    func loadChefs() {
        ChefViewModel.sharedInstance.getAll { succes, reponse in
            if succes {
                self.chefs = reponse!
            } else {
                self.present(Alert.makeAlert(titre: "Error", message: "Could not load chefs"), animated: true)
            }
            self.chefsTableView.reloadData()
        }
    }
}
