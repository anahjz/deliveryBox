//
//  Delivery.swift
//  Lalamove
//
//  Created by admin on 11/18/19.
//  Copyright © 2019 AnaHejazi. All rights reserved.
//

import Foundation

class  DeliveryData: NSObject {
    
    var id: Int?
    var descriptions: String?
    var imageUrl: String?
    var lat: Double?
    var lng: Double?
    var address: String?

    
    init(id: Int, descriptions: String, imageUrl: String, lat: Double, lng: Double, address: String) {
        
        self.id = id
        self.descriptions = descriptions
        self.imageUrl = imageUrl
        self.lat = lat
        self.lng = lng
        self.address = address
        
    }
    
}
