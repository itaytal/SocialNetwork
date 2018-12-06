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

    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
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
    
    
    @IBAction func signInClicked(_ sender: Any) {
        
        if let email = emailText.text, let pwd = passwordText.text {
            
            Auth.auth().signIn(withEmail: email, password: pwd, completion:  { (user, error) in
            
                if error == nil {
                    print("successfully login")
                }
                else{
                    Auth.auth().createUser(withEmail: email, password: pwd, completion: { (user, error) in
                        if error != nil {
                            print("error in crate user with firebase with email")
                            print(error.debugDescription)
                        }
                        else{
                            print("successfully crate user with firebase")
                        }
                    })
                }
                
            })
        }
        
    }
    
    

}

