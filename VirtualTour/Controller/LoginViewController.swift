//
//  LoginViewController.swift
//  VirtualTour
//
//  Created by Abdullah alammar on 23/06/2019.
//  Copyright © 2019 Abdullah alammar. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
           activityIndicator.isHidden = true
       
        
    }
    @IBAction func login(_ sender: UIButton) {
        
        
        
        
        updateUI(processing: true)
        
        guard let email = emailField.text?.trimmingCharacters(in: .whitespaces),
            let password=passwordField.text?.trimmingCharacters(in: .whitespaces), !email.isEmpty , !password.isEmpty
            else {
                
                alert(title: "Warning"  , message : "Email or password should not be empty" )
                updateUI(processing: false)
                
                return
        }
        
        
        DispatchQueue.main.async {
            self.updateUI(processing: true)
            
            self.activityIndicator.isHidden = false
             self.activityIndicator.startAnimating()
            
        
        UdacityAPI.PostSession(with: email, password: password) {
            (result, error) in
            
            if let error = error {
                self.alert(title: "ERROR"  , message : error.localizedDescription )
                self.updateUI(processing: false)
                return
            }
            
            if let error = result?["error"] as? String {
                self.alert(title: "ERROR"  , message : error )
                self.updateUI(processing: false)
                return
                
                
            }
            
            if let session = result?["session"] as? [String:Any], let sessionId = session["id"] as? String {
                
                print(sessionId)
                UdacityAPI.deleteSession {
                    (error) in
                    
                    if let error = error {
                        self.alert(title: "ERROR"  , message : error.localizedDescription )
                        self.updateUI(processing: false)
                        return
                    }
                    self.updateUI(processing: false)
                    DispatchQueue.main.async {
                        
                        self.emailField.text = ""
                        self.passwordField.text = ""
                         self.activityIndicator.isHidden = true
                        self.activityIndicator.stopAnimating()

                        self.performSegue(withIdentifier: "loginToHome", sender: self)
                        
                    }
                    
                    
                    
                    
                }
                
                
            }
            
     
            };self.updateUI(processing: false) ;
        }
        
    }
    
    
    func updateUI(processing : Bool) {
        
        DispatchQueue.main.async {
            
//            self.activityIndicator.isHidden = !processing
            self.emailField.isUserInteractionEnabled = !processing
            self.passwordField.isUserInteractionEnabled = !processing
            self.loginBtn.isEnabled = !processing
        }
    }
    
}

    
    
    
