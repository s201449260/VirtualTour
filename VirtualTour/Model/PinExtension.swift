//
//  PinExtension.swift
//  VirtualTour
//
//  Created by Abdullah alammar on 10/06/2019.
//  Copyright © 2019 Abdullah alammar. All rights reserved.
//



import Foundation
import MapKit
import CoreData

extension Pin {
    
    var coordinate : CLLocationCoordinate2D{
        set {
            
            latitude = newValue.latitude
            longitude = newValue.longitude
        }
        
        get {
            return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        }
        
        
        
    }
    
    func compare(to coordinate:CLLocationCoordinate2D ) -> Bool {
        
        return (latitude == coordinate.latitude && longitude == coordinate.longitude)
        
    }
    
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        createdAt = Date()
    }
    
    
}
