//
//  OrdersVC.swift
//  Kouzina
//
//  Created by Anil Dhameliya on 21/11/21.
//

import UIKit
import FittedSheets

class OrdersVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var orders: [Order] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("happen")
        let cell = tableView.dequeueReusableCell(withIdentifier: "mCell", for: indexPath)
        let contentView = cell.contentView
        let typeLabel = contentView.viewWithTag(1) as! UILabel
        let emplacementLabel = contentView.viewWithTag(2) as! UILabel
        let platLabel = contentView.viewWithTag(3) as! UILabel
        
        let order = orders[indexPath.row]
        
        typeLabel.text = order.type
        emplacementLabel.text = order.emplacement
        platLabel.text = String(order.plat!)
        
        return cell
    }
    
    @IBAction func btnCheckOutClicked(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadOrders()
    }
    
    // methods
    func loadOrders() {
        OrderViewModel().getAllOrders { succes, reponse in
            self.orders = []
            if succes {
                for order in reponse!{
                    self.orders.append(order)
                }
                print("-----------------------------------")
                print(reponse)
                print("-----------------------------------")
                self.tableView.reloadData()
            }
            else{
                self.present(Alert.makeAlert(titre: "Error", message: "Could not load plats"), animated: true)
            }
        }
    }
}
