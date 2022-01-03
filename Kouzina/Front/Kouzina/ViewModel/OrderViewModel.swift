//
//  OrderViewModel.swift
//  Kouzina
//
//  Created by Apple Esprit on 12/12/2021.
//

import Foundation
import SwiftyJSON
import Alamofire
import UIKit.UIImage

class OrderViewModel {
    
    static let sharedInstance = OrderViewModel()
    
    func getAll(  completed: @escaping (Bool, [Order]?) -> Void ) {
        AF.request(HOST + "order",
                   method: .get)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    let jsonData = JSON(response.data!)["orders"]
                    var orders : [Order]? = []
                    for singleJsonItem in jsonData {
                        orders!.append(self.makeOrder(jsonItem: singleJsonItem.1))
                    }
                    completed(true, orders)
                case let .failure(error):
                    debugPrint(error)
                    completed(false, nil)
                }
            }
    }
    
    func add(order: Order, completed: @escaping (Bool) -> Void ) {
        AF.request(HOST + "order",
                   method: .post,
                         parameters: [
                            "type": order.type,
                            "emplacement": order.emplacement,
                            "plat": (order.plat?._id)!
                         ])
                  .validate(statusCode: 200..<300)
                  .validate(contentType: ["application/json"])
                  .responseData { response in
                      switch response.result {
                      case .success:
                          completed(true)
                      case let .failure(error):
                          print(error)
                          completed(false)
                      }
                  }
    }
    
    func makeOrder(jsonItem: JSON) -> Order {
        return Order(
            _id: jsonItem["_id"].stringValue,
            type: jsonItem["type"].stringValue,
            emplacement: jsonItem["emplacement"].stringValue,
            plat: PlatViewModel.sharedInstance.makePlat(jsonItem: jsonItem["plat"])
        )
    }
}
