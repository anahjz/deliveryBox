//
//  EndPoints.swift
//  Lalamove
//
//  Created by admin on 11/18/19.
//  Copyright © 2019 AnaHejazi. All rights reserved.
//

import Foundation

enum EndPoints: String {
    
    case getDeliveries = "/deliveries"
    
    var description: String {
        return self.rawValue
    }
}
