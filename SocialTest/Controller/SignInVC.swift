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
import SwiftKeychainWrapper

class SignInVC: UIViewController {

    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewDidAppear(_ animated: Bool) {
        
        if KeychainWrapper.standard.string(forKey: KEY_UID) != nil {
            performSegue(withIdentifier: "goToFeed", sender: nil)
        }
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
                        if let user = authResult {
                            let userData = ["provider":credential.provider]
                            self.completeSignIn(id: user.user.uid, userData: userData)
                        }
                        
                        
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
                    if let user = user {
                        let userData = ["provider": user.user.providerID]
                        self.completeSignIn(id: user.user.uid, userData: userData)
                    }
                    print("successfully login")
                }
                else{
                    Auth.auth().createUser(withEmail: email, password: pwd, completion: { (user, error) in
                        if error != nil {
                            print("error in crate user with firebase with email")
                            print(error.debugDescription)
                        }
                        else{
                            if let user = user {
                                let userData = ["provider": user.user.providerID]
                                self.completeSignIn(id: user.user.uid, userData: userData)
                            }
                            print("successfully crate user with firebase")
                        }
                    })
                }
                
            })
        }
    }
    
    func completeSignIn(id: String, userData: Dictionary<String, String>) {
        
        DataServices.ds.createFirebaseDBUser(uid: id, userData: userData)
        
        let keycahin = KeychainWrapper.standard.set(id, forKey: KEY_UID)
        print("itay: data save in keychain \(keycahin)")
        performSegue(withIdentifier: "goToFeed", sender: nil)
    }
    
    
    
    

}

