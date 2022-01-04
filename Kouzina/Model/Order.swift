//
//  Order.swift
//  Kouzina
//
//  Created by Apple Esprit on 12/12/2021.
//

import Foundation

struct Order {
    
    internal init(_id: String? = nil, type: String, emplacement: String, plat: Plat? = nil) {
        self._id = _id
        self.type = type
        self.emplacement = emplacement
        self.plat = plat
    }
    
    var _id: String?
    var type: String
    var emplacement: String
    var plat: Plat?
    
}
