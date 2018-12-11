//
//  DataServices.swift
//  SocialTest
//
//  Created by Globes Design on 11/12/2018.
//  Copyright © 2018 Globes Design. All rights reserved.
//

import Foundation
import Firebase



let DB_BASE = Database.database().reference()

class DataServices {

    static let ds = DataServices()
    
    
   
    
    private var _REF_BASE = DB_BASE
     var _REF_POSTS = DB_BASE.child("posts")
    private var _REF_USERS = DB_BASE.child("users")
    
    
    var REF_BASE : DatabaseReference {
        return _REF_BASE
    }
    
    var REF_POSTS : DatabaseReference {
        return _REF_POSTS
    }
    
    var REF_USERS : DatabaseReference {
        return _REF_USERS
    }
    
    func createFirebaseDBUser(uid: String, userData: Dictionary<String,String>){
        REF_USERS.child(uid).updateChildValues(userData)
    }

    
}
