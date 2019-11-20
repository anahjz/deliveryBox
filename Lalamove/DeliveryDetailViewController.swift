//
//  DeliveryDetailViewController.swift
//  Lalamove
//
//  Created by admin on 11/19/19.
//  Copyright © 2019 AnaHejazi. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreLocation


class DeliveryDetailViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    
    @IBOutlet weak var mapKit: MKMapView!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var deliveryDescription: UILabel!
    
    var delivery:  DeliveryData?
    private let locationManager = CLLocationManager()
    private var currentLocation = CLLocationCoordinate2D()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        prepareViews()
        prepareMap()
        
    }
    
    private func prepareViews(){
        
        guard (delivery != nil) else {
            return
        }
        
        self.address.text = delivery?.address
        self.deliveryDescription.text = delivery?.descriptions
        
    }
    
    private func prepareMap(){
        
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        self.mapKit.showsUserLocation = true
        
        let location = CLLocationCoordinate2D(latitude: delivery?.lat ?? 0.0,
                                              longitude: delivery?.lng ?? 0.0 )
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = delivery?.address ?? "unknown name"
        mapKit.addAnnotation(annotation)
        
        mapKit.isZoomEnabled = true
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        
        let location = locations.last
        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
        
        self.mapKit.setRegion(region, animated: true)
        self.locationManager.stopUpdatingLocation()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        print("Errors " + error.localizedDescription)
        
    }
    
    
}

