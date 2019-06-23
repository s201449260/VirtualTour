//
//  UdacityAPI.swift
//  VirtualTour
//
//  Created by Abdullah alammar on 23/06/2019.
//  Copyright © 2019 Abdullah alammar. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class UdacityAPI {
    
    static func PostSession(with email:String, password: String , completion: @escaping ([String:Any]? , Error?) -> ()) {
        
        var request = URLRequest(url: URL(string: "https://onthemap-api.udacity.com/v1/session")!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        // encoding a JSON body from a string, can also use a Codable struct
        request.httpBody = "{\"udacity\": {\"username\": \"\(email)\", \"password\": \"\(password)\"}}".data(using: .utf8)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil { // Handle error…
                completion(nil , error)
                return
            }
            let range = (5..<data!.count)
            let newData = data?.subdata(in: range) /* subset response data! */
            let result = try! JSONSerialization.jsonObject(with: newData!, options: JSONSerialization.ReadingOptions.allowFragments) as! [String:Any]
            completion(result , nil)
            
            print(String(data: newData!, encoding: .utf8)!)
        }
        task.resume()
        
        
        
    }
    
    
    
    static func deleteSession(completion: @escaping (Error?) -> ()){
        
        
        var request = URLRequest(url: URL(string: "https://onthemap-api.udacity.com/v1/session")!)
        request.httpMethod = "DELETE"
        var xsrfCookie: HTTPCookie? = nil
        let sharedCookieStorage = HTTPCookieStorage.shared
        for cookie in sharedCookieStorage.cookies! {
            if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
        }
        if let xsrfCookie = xsrfCookie {
            request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
        }
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil { // Handle error…
                completion(error)
                return
            }
            let range = (5..<data!.count)
            let newData = data?.subdata(in: range) /* subset response data! */
            
            print(String(data: newData!, encoding: .utf8)!)
            completion(nil)
            
        }
        task.resume()
        
    }
    
   
    
}
