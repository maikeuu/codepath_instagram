//
//  PostTableViewCell.swift
//  instagram
//
//  Created by Mike Lin on 2/25/18.
//  Copyright © 2018 Mike Lin. All rights reserved.
//

import UIKit
import ParseUI
import Parse

class PostsTableViewCell: UITableViewCell {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var postImage: PFImageView!
    @IBOutlet weak var captionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

}
