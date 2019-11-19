//
//  MyDeliveriesViewModel.swift
//  Lalamove
//
//  Created by admin on 11/18/19.
//  Copyright © 2019 AnaHejazi. All rights reserved.
//

import Foundation
import SwiftyJSON

class MyDeliveriesViewModel: NetworkManagerDelegate {
    
    weak var delegate: ViewModelDelegate?
    private let networkManager = NetworkManager()
    private var offset: Int = 0
    private let limit: Int = 8
    
    var deliveryDatas = [DeliveryData]()
    var shouldShowLoadingCell = true

    
    init() {
        
        networkManager.delegate = self
        
    }
    
    func getMyDeliveries(){
        
        if offset == 0 {
            
            self.delegate?.progressBarStartAnimating()
            
        }
        
        networkManager.getMyDeliveries(limit: limit, offset: offset)

    }
    
    func dataReceived(data: Any?, error: NSError?) {
        
        if error != nil {
            print("Error: \(String(describing: error))")
        }
        
        guard let data = data else {
            print("Error: No data")
            self.delegate?.emptyData()
            return
        }
        let json = JSON(data)
        let strongSelf = self
    
        strongSelf.deliveryDatas = Utilities.loadMyDeliveriesFromJSON(json: json)
        strongSelf.delegate?.dataRecieved()
        strongSelf.delegate?.progressBarStopAnimating()
        
        if deliveryDatas.count >= limit{
            
            offset += limit
            shouldShowLoadingCell = true
            
        } else {
            
            shouldShowLoadingCell = false
        }

        
    }
    
}


protocol ViewModelDelegate: class {
    
    func dataRecieved()
    func emptyData()
    func progressBarStartAnimating()
    func progressBarStopAnimating()

}
