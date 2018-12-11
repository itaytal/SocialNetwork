//
//  PostCell.swift
//  SocialTest
//
//  Created by Globes Design on 10/12/2018.
//  Copyright © 2018 Globes Design. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {

    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var caption: UITextView!
    @IBOutlet weak var likesLbl: UILabel!
    
    var post: Post!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func configeCell(post: Post){
        self.post = post
        self.caption.text = post.caption
        self.likesLbl.text = "\(post.likes)"
        
    }



}
