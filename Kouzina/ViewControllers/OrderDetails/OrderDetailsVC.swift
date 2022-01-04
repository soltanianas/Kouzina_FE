//
//  OrderDetailsVC.swift
//  Kouzina
//
//  Created by Anil Dhameliya on 21/11/21.
//

import UIKit

class OrderDetailsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // VARIABLES
    var orders : [Order] = []
    
    // WIDGETS
    @IBOutlet weak var tableview: UITableView!
    
    // PROTOCOLS
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "mCell")
        let contentView = cell?.contentView
        
        let platImage = contentView?.viewWithTag(1) as! UIImageView
        let nomPlatLabel = contentView?.viewWithTag(2) as! UILabel
        let typeLabel = contentView?.viewWithTag(3) as! UILabel
        let emplacementLabel = contentView?.viewWithTag(4) as! UILabel
        
        let order = orders[indexPath.row]
        let plat = order.plat!
        
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
        
        nomPlatLabel.text = plat.description
        typeLabel.text = order.type
        emplacementLabel.text = order.emplacement
        
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
        OrderViewModel.sharedInstance.getAll { [self] success, ordersFromRep in
            if success {
                orders = ordersFromRep!
                
                self.tableview.reloadData()
            }else {
                self.present(Alert.makeAlert(titre: "Error", message: "Could not load formations "),animated: true)
            }
        }
    }
    
    // METHODS
    
    
    // ACTIONS
    @IBAction func btnPlaceMyOrderClicked(_ sender: Any) {
        let obj = AppStoryboard.Main.instance.instantiateViewController(withIdentifier: "TrackOrderVC") as! TrackOrderVC
        obj.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(obj, animated: true)
    }
    
}
