//
//  ChefViewModel.swift
//  Carypark
//
//  Created by Mac-Mini_2021 on 10/11/2021.
//

import SwiftyJSON
import Alamofire
import UIKit.UIImage

class ChefViewModel {
    
    static let sharedInstance = ChefViewModel()
    
    func getAll(completed: @escaping (Bool, [Chef]?) -> Void ) {
        AF.request(HOST + "chef",
                   method: .get)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    let jsonData = JSON(response.data!)["chefs"]
                    
                    var chefs : [Chef]? = []
                    for singleJsonItem in jsonData {
                        chefs!.append(self.makeChef(jsonItem: singleJsonItem.1))
                    }
                    completed(true, chefs)
                case let .failure(error):
                    debugPrint(error)
                    completed(false, nil)
                }
            }
    }
    
    func add(chef: Chef, uiImage: UIImage, completed: @escaping (Bool) -> Void ) {
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(uiImage.jpegData(compressionQuality: 0.5)!, withName: "image" , fileName: "image.jpeg", mimeType: "image/jpeg")
            
            for (key, value) in
                    [
                        "nom": chef.nom
                    ]
            {
                multipartFormData.append((value.data(using: .utf8))!, withName: key)
            }
            
        },to: HOST + "chef",
                  method: .post)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    print("Success")
                    completed(true)
                case let .failure(error):
                    completed(false)
                    print(error)
                }
            }
    }
    func makeChef(jsonItem: JSON) -> Chef {
        Chef(
            _id: jsonItem["_id"].stringValue,
            nom: jsonItem["nom"].stringValue,
            image: jsonItem["image"].stringValue
        )
    }
}
