//
//  Post.swift
//  SocialTest
//
//  Created by Globes Design on 12/12/2018.
//  Copyright © 2018 Globes Design. All rights reserved.
//

import Foundation
import Firebase

class Post {
    
    private var _caption: String!
    private var _imageUrl: String!
    private var _likes: Int!
    private var _postKey: String!
    private var _postRef: DatabaseReference!

    
    var caption: String {
        return _caption
    }
    
    var imageUrl: String {
        return _imageUrl
    }
    
    var likes: Int {
        return _likes
    }
    
    var postKey: String {
        return _postKey
    }
    
    init(caption: String, imageUrl: String, likes: Int) {
        self._caption = caption
        self._imageUrl = caption
        self._likes = likes
    }
    
    init(postKey: String, postData: Dictionary<String, AnyObject>) {
        self._postKey = postKey
        
        if let caption = postData["caption"] as? String{
            self._caption = caption
        }
        
        if let imageUrl = postData["imageUrl"] as? String{
            self._imageUrl = imageUrl
        }
        if let likes = postData["likes"] as? Int {
            self._likes = likes
        }
        
        _postRef = DataServices.ds.REF_POSTS.child(_postKey)
    }

    

    func adjustLikes(addlike: Bool){
        if addlike {
            _likes += 1
            
        }
        else {
            _likes -= 1
        }
        _postRef.child("likes").setValue(_likes)
    }
}
