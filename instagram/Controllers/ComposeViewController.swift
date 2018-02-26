//
//  ComposeViewController.swift
//  instagram
//
//  Created by Mike Lin on 2/25/18.
//  Copyright © 2018 Mike Lin. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var cancelBarButton: UIBarButtonItem!
    @IBOutlet weak var shareBarButton: UIBarButtonItem!
    @IBOutlet weak var postImage: UIImageView?
    @IBOutlet weak var captionTextField: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func uploadPost(_ sender: Any) {
        guard let postImage = postImage else {
            return
        }
     Post.postUserImage(image: postImage.image, withCaption: captionTextField.text, withCompletion: nil)
        print("Post successfully saved")
        self.dismiss(animated: true, completion: nil)
    }
    
    func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRect.init(x: 0, y: 0, width: newSize.width, height: newSize.height))
        resizeImageView.contentMode = UIViewContentMode.scaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        postImage!.image = resize(image: editedImage, newSize: CGSize.init(width: 128, height: 128))
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func imageTapped(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.photoLibrary
        self.present(vc, animated: true, completion: nil)
        print("this is working")
    }
    
    @IBAction func cancelPost(_ sender: UIBarButtonItem) {
//        let homeScreen = UIStoryboard(name: "Main", bundle: nil)
//        self.present(homeScreen.instantiateViewController(withIdentifier: "HomeScreen"), animated: false, completion: nil)
        dismiss(animated: false, completion: nil)
    }
}
