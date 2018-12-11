//
//  File.swift
//  SocialTest
//
//  Created by Globes Design on 11/12/2018.
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
}
