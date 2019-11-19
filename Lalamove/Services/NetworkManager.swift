//
//  BaseService.swift
//  Lalamove
//
//  Created by admin on 11/18/19.
//  Copyright © 2019 AnaHejazi. All rights reserved.
//

import Foundation
import Alamofire

protocol NetworkManagerDelegate {
    
    func dataReceived(data: Any?, error: NSError?)
    
}


class NetworkManager: NSObject {
    
    var delegate: NetworkManagerDelegate?
    
    func getMyDeliveries(limit: Int, offset: Int) {
        
        let requestURL: String = "\(AppConstants.baseUrl)\(EndPoints.getDeliveries.description)?limit=\(limit)&offset=\(offset)"
        Alamofire.request(requestURL).responseJSON { (response) in
            switch response.result {
            case .success:
                guard let json = response.result.value else {
                    return
                }
                self.delegate?.dataReceived(data: json, error: nil)
            case .failure(let error):
                self.delegate?.dataReceived(data: nil, error: error as NSError)
            }
            
        }
        
    }
    
}
