//
//  DetailViewController.swift
//  instagram
//
//  Created by Mike Lin on 2/26/18.
//  Copyright © 2018 Mike Lin. All rights reserved.
//

import UIKit
import ParseUI

class DetailViewController: UIViewController {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var postImage: PFImageView!
    @IBOutlet weak var captionLabel: UILabel!
    
    var post: Post?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let post = post {
            usernameLabel.text = post.author.username
            postImage.file = post.picture
            postImage.loadInBackground()
            captionLabel.text = post.caption
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
