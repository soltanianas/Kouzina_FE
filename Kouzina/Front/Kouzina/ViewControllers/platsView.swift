//
//  platsView.swift
//  Kouzina
//
//  Created by Apple Esprit on 12/12/2021.
//

import Foundation
import UIKit

class PlatsView: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // variables
    var plats = [Plat]()
    var platForDetails : Plat?
    
    // iboutlets
    @IBOutlet weak var platsTableView: UITableView!
    
    
    // protocols
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        plats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mCell", for: indexPath)
        let contentView = cell.contentView
        let platImage = contentView.viewWithTag(1) as! UIImageView
        let descLabel = contentView.viewWithTag(2) as! UILabel
        let compoLabel = contentView.viewWithTag(3) as! UILabel
        let prixLabel = contentView.viewWithTag(4) as! UILabel
        
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
        
        descLabel.text = plat.description
        compoLabel.text = plat.composition
        prixLabel.text = String(plat.prix!)
        
        return cell
    }
    
    // life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadPlats(tv: self.platsTableView)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        platsTableView.reloadData()
    }
    
    // methods
    func loadPlats(tv: UITableView) {
        PlatViewModel().getAllPlats { succes, reponse in
            if succes {
                for plat in reponse!{
                    self.plats.append(plat)
                }
            }
            else{
                self.present(Alert.makeAlert(titre: "Error", message: "Could not load plats"), animated: true)
            }
        }
    }
}
