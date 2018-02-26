//
//  Post.swift
//  instagram
//
//  Created by Mike Lin on 2/25/18.
//  Copyright © 2018 Mike Lin. All rights reserved.
//

import Foundation
import Parse

class Post: PFObject, PFSubclassing {
    @NSManaged var picture: PFFile
    @NSManaged var author: PFUser
    @NSManaged var caption: String
    @NSManaged var likesCount: Int
    @NSManaged var commentsCount: Int

    //returns the Parse name that should be used
    static func parseClassName() -> String {
        return "Post"
    }
    
    /**
     Method to add a user post to Parse (uploading image file)
     
     - parameter image: Image that the user wants upload to parse
     - parameter caption: Caption text input by the user
     - parameter completion: Block to be executed after save operation is complete
     */
    class func postUserImage(image: UIImage?, withCaption caption: String?, withCompletion completion: PFBooleanResultBlock?) {
        let post = Post()
        
        //initialize properties of the post
        post.picture = getPFFileFromImage(image: image)!
        post.author = PFUser.current()!
        post.caption = caption!
        post.likesCount = 0
        post.commentsCount = 0
        
        //Save object to post
        post.saveInBackground(block: completion)
    }
    
    /**
     Method to convert UIImage to PFFile
     
     - parameter image: Image that the user wants to upload to parse
     
     - returns: PFFile for the the data in the image
     */
    class func getPFFileFromImage(image: UIImage?) -> PFFile? {
        // check if image is not nil
        if let image = image {
            // get image data and check if that is not nil
            if let imageData = UIImagePNGRepresentation(image) {
                return PFFile(name: "image.png", data: imageData)
            }
        }
        return nil
    }
    
}
