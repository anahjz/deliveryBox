//
//  Utilities.swift
//  Lalamove
//
//  Created by admin on 11/19/19.
//  Copyright © 2019 AnaHejazi. All rights reserved.
//

import Foundation
import SwiftyJSON

class Utilities {
    
    class func loadMyDeliveriesFromJSON(json: JSON) -> [DeliveryData] {
        
        var myDeliveries: [DeliveryData] = []
        
        guard let deliveries = json.array else {
            print("There is no array")
            return []
        }
        
        for delivery in deliveries {
            
            guard let id = delivery["id"].int,
                let description = delivery["description"].string,
                let imageUrl = delivery["imageUrl"].string,
                let lat = delivery["location"]["lat"].double,
                let lng = delivery["location"]["lng"].double,
                let address = delivery["location"]["address"].string else {
                    
                    print("Error in serializing data")
                    return []
                    
            }
            
            let deliveryData = DeliveryData(id: id, descriptions: description, imageUrl: imageUrl, lat: lat, lng: lng, address: address)
            
            myDeliveries.append(deliveryData)
            
        }
        
        return myDeliveries
    }
}
