//
//  UIViewController.swift
//  VirtualTour
//
//  Created by Abdullah alammar on 10/06/2019.
//  Copyright © 2019 Abdullah alammar. All rights reserved.
//

import Foundation

import UIKit

extension UIViewController {
    
    func alert (title : String , message : String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        DispatchQueue.main.async {
            self.present(alert , animated: true , completion: nil)
        }
        
        
    }
}
