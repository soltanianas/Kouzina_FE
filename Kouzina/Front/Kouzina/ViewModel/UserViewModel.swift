//
//  UserViewModel.swift
//  Kouzina
//
//  Created by Apple Esprit on 11/12/2021.
//

import SwiftyJSON
import Alamofire
import UIKit.UIImage

public class UserViewModel: ObservableObject{
    
    init(){}
    
    func inscription(user: User, completed: @escaping (Bool) -> Void) {
        AF.request(HOST + "/users/signup",
                   method: .post,
                   parameters: [
                    "nom": user.nom!,
                    "email": user.email!,
                    "password": user.password!
                   ])
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    print("Validation Successful")
                    completed(true)
                case let .failure(error):
                    print(error)
                    completed(false)
                }
            }
    }
    
    func connexion(email: String, mdp: String, completed: @escaping (Bool, Any?) -> Void) {
        AF.request(HOST + "/users/login",
                   method: .post,
                   parameters: ["email": email, "password": mdp])
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    let jsonData = JSON(response.data!)
                    print(jsonData)
                    let user = self.makeItem(jsonItem: jsonData["user"])
                    UserDefaults.standard.setValue(jsonData["token"].stringValue, forKey: "userToken")
                    UserDefaults.standard.setValue(user.email, forKey: "userEmail")
                    UserDefaults.standard.setValue(user.nom, forKey: "userNom")
                    UserDefaults.standard.setValue(user.role, forKey: "userRole")
                    UserDefaults.standard.setValue("isNew", forKey: "isItNew")
                    print(user)
                    
                    completed(true, user)
                case let .failure(error):
                    debugPrint(error)
                    completed(false, nil)
                }
            }
    }
    
    func loginWithSocialApp(email: String, nom: String, completed: @escaping (Bool, User?) -> Void ) {
        AF.request(HOST + "/users/loginWithSocial",
                   method: .post,
                   parameters: ["email": email, "nom": nom],
                   encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .response { response in
                switch response.result {
                case .success:
                    let jsonData = JSON(response.data!)
                    let user = self.makeItem(jsonItem: jsonData["user"])
                    
                    print("this is the new token value : " + jsonData["token"].stringValue)
                    print(jsonData)
                    UserDefaults.standard.setValue(jsonData["token"].stringValue, forKey: "tokenConnexion")
                    UserDefaults.standard.setValue(user.email, forKey: "userEmail")
                    UserDefaults.standard.setValue(user.nom, forKey: "userNom")
                    UserDefaults.standard.setValue(user.role, forKey: "userRole")
                    UserDefaults.standard.setValue("isNew", forKey: "isItNew")
                    completed(true, user)
                case let .failure(error):
                    debugPrint(error)
                    completed(false, nil)
                }
            }
    }
    
    func motDePasseOublie(email: String, codeDeReinit: String, completed: @escaping (Bool) -> Void) {
        AF.request(HOST + "/users/motDePasseOublie",
                   method: .post,
                   parameters: ["email": email, "codeDeReinit": codeDeReinit])
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    print("Validation Successful")
                    completed(true)
                case let .failure(error):
                    print(error)
                    completed(false)
                }
            }
    }
    
    func changerMotDePasse(email: String, nouveauMotDePasse: String, completed: @escaping (Bool) -> Void) {
        AF.request(HOST + "/users/changerMotDePasse",
                   method: .put,
                   parameters: ["email": email,"nouveauMotDePasse": nouveauMotDePasse])
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    print("Validation Successful")
                    completed(true)
                case let .failure(error):
                    print(error)
                    completed(false)
                }
            }
    }
    
    func recupererUserParID(_id: Int?) -> User {
        var data: User?
        
        AF.request(HOST + "/users",
                   method: .get,
                   parameters: ["_id": String(_id!)])
            .responseJSON(completionHandler: { jsonResponse in
                let jsonResponse = JSON(jsonResponse)[0]
                
                data = self.makeItem(jsonItem: jsonResponse)
            })
        
        return data!
    }
    
    func recupererToutUser() -> [User] {
        var data: [User]?
        
        AF.request(HOST + "/users").responseJSON(completionHandler: { jsonResponse in
            let jsonResponse = JSON(jsonResponse)
            
            for (_,subJson):(String, JSON) in jsonResponse {
                data!.append(self.makeItem(jsonItem: subJson))
            }
        })
        
        return data!
    }
    
    func makeItem(jsonItem: JSON) -> User {
        return User(
            _id: jsonItem["_id"].stringValue,
            nom: jsonItem["nom"].stringValue,
            email: jsonItem["email"].stringValue,
            password: jsonItem["password"].stringValue,
            image: jsonItem["image"].stringValue,
            role: jsonItem["role"].stringValue
        )
    }
    
}
