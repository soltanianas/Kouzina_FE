//
//  PlatViewModel.swift
//  Kouzina
//
//  Created by Apple Esprit on 12/12/2021.
//

import Foundation
import SwiftyJSON
import Alamofire
import UIKit.UIImage

class PlatViewModel {
    
    func getAllPlats(  completed: @escaping (Bool, [Plat]?) -> Void ) {
        AF.request(HOST + "/plat/get/all",
                   method: .post)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    let jsonData = JSON(response.data!)
                    
                    var plats : [Plat]? = []
                    for singleJsonItem in jsonData["plat"] {
                        plats!.append(self.makePlat(jsonItem: singleJsonItem.1))
                    }
                    completed(true, plats)
                case let .failure(error):
                    debugPrint(error)
                    completed(false, nil)
                }
            }
    }
    
    func addPlat(plat: Plat, uiImage: UIImage, completed: @escaping (Bool) -> Void ) {
        
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(uiImage.jpegData(compressionQuality: 0.5)!, withName: "image" , fileName: "image.jpeg", mimeType: "image/jpeg")
            
            for (key, value) in
                    [
                        "prix": String(plat.prix!),
                        "description": plat.description!,
                        "composition": plat.composition!
                    ]
            {
                multipartFormData.append((value.data(using: .utf8))!, withName: key)
            }
            
        },to: HOST + "/plat/add",
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
    
    func makePlat(jsonItem: JSON) -> Plat {
        return Plat(
            _id: jsonItem["_id"].stringValue,
            prix: jsonItem["prix"].floatValue,
            description: jsonItem["description"].stringValue,
            composition: jsonItem["composition"].stringValue,
            image: jsonItem["image"].stringValue
        )
    }
}
