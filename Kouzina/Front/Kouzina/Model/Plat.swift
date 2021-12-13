//
//  Plat.swift
//  Kouzina
//
//  Created by Apple Esprit on 12/12/2021.
//

import Foundation

struct Plat {
    internal init(_id: String? = nil, prix: Float? = nil, description: String? = nil, composition: String? = nil, image: String? = nil) {
        self._id = _id
        self.prix = prix
        self.description = description
        self.composition = composition
        self.image = image
    }
    
    
    
    var _id: String?
    var prix : Float?
    var description : String?
    var composition : String?
    var image : String?
}
