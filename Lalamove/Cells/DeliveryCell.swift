//
//  DeliveryCell.swift
//  Lalamove
//
//  Created by admin on 11/18/19.
//  Copyright © 2019 AnaHejazi. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class DeliveryCell: UITableViewCell {
    
    @IBOutlet weak var deliveryImage: UIImageView!
    @IBOutlet weak var deliveryAddress: UILabel!
    @IBOutlet weak var deliveryDescription: UILabel!
    
    var delivery: DeliveryData? {
        didSet {
            updateUI()
        }
    }
    
    
    private func updateUI(){
        
        func updateDeliveryImage(){
            
            let imageUrl = URL(string: delivery?.imageUrl ?? "https://assets-global.website-files.com/5ab9f6adcd72e6536e58c8d2/5bff60461acf7f414f42f43e_lalamove-hero.jpg")
            self.deliveryImage.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeHolder"))
            
        }
        
        func updateDeliveryAddress() {
            
            guard let delAddress = delivery?.address else {
                
                return self.deliveryAddress.text = "Unknown address!!"
                
            }
            
            self.deliveryAddress.text = delAddress
            
        }
        
        func updateDeliveryDescription() {
            
            guard let delDescription = delivery?.descriptions else {
                
                return self.deliveryDescription.text = "No description!!"
                
            }
            
            self.deliveryDescription.text = delDescription
            
        }
        
        updateDeliveryAddress()
        updateDeliveryDescription()
        updateDeliveryImage()
    
    }
}
