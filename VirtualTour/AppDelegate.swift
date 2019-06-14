//
//  AppDelegate.swift
//  VirtualTour
//
//  Created by Abdullah alammar on 07/06/2019.
//  Copyright © 2019 Abdullah alammar. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        DataController.shared.load()
        
        return true
    }
    
    func saveViewContext(){
        
        try? DataController.shared.viewContext.save()
        
    }

   

    func applicationDidEnterBackground(_ application: UIApplication) {
            saveViewContext()

    }

  

    func applicationWillTerminate(_ application: UIApplication) {
        
        
        saveViewContext()
    }

   
    
}

