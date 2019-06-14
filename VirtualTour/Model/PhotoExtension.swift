//
//  PhotoExtension.swift
//  VirtualTour
//
//  Created by Abdullah alammar on 10/06/2019.
//  Copyright © 2019 Abdullah alammar. All rights reserved.
//

import Foundation
import MapKit

extension Photo {
    
    func set(image : UIImage){
        
        self.image = image.pngData()
    }
    
    func getImage() -> UIImage? {
        
        return (image == nil ) ? nil : UIImage(data: image!)
    }
    
    
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        
        createdAt = Date()
    }
    
}
