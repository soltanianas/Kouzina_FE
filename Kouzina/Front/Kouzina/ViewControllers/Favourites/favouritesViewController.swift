//
//  favouritesViewController.swift
//  Kouzina
//
//  Created by Apple Esprit on 29/12/2021.
//

import UIKit
import SwiftyJSON
import Alamofire



class favouritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
   
    @IBOutlet weak var orderTv: UITableView!
    
    var orderList = [String]()
    var emplacementList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadOrder()
        // Do any additional setup after loading the view.
    }
    

   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellA = tableView.dequeueReusableCell(withIdentifier: "favCell", for: indexPath)
        let cv = cellA.contentView
        let orderName = cv.viewWithTag(1) as! UILabel
        
      
        let emplacement = cv.viewWithTag(2) as! UILabel
      
        orderName.text = orderList[indexPath.row]
        
        emplacement.text = emplacementList[indexPath.row]
       
        
        
        
        return cellA
        
    }
    
    
    
    
    
    func loadOrder()  {
        AF.request(HOST+"/order/favourite", method: .get).responseJSON{
            response in
            switch response.result{
                
            case .success:
               // print(response)
                let myresult = try? JSON(data: response.data!)
                print(myresult!)
                self.orderList.removeAll()
                self.emplacementList.removeAll()
                
                
                for i in myresult!.arrayValue {
                    print(i)
                    
                    let type = i["type"].stringValue
                    let emplacement = i["emplacement"].stringValue
                  
                    self.orderList.append(type)
                    self.emplacementList.append(emplacement)
                   
                    // print(id)
                }
                self.orderTv.reloadData()
                break
            case .failure:
                print(response.error!)
                
                break
            }
        }
    }

}
