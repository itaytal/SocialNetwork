//
//  ViewController.swift
//  SocialTest
//
//  Created by Globes Design on 04/12/2018.
//  Copyright © 2018 Globes Design. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase

class SignInVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    @IBAction func facebookBtntapped(_ sender: Any) {
        
        let facebooklogin = FBSDKLoginManager()
        
        facebooklogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error != nil {
                print("error auth with facebook")
            } else if result?.isCancelled == true {
                print("user cancelled")
            }else {
                print("successfully authenticated with facebook")
                
                
                
                let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                
                Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
                    if  error != nil {
                        print("Unable auth with firebase")
                        return
                    }else {
                        print("successfully authnticated with firebase")
                    }
                    
            }
        }
        
    }
}

}

