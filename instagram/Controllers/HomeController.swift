//
//  HomeController.swift
//  instagram
//
//  Created by Mike Lin on 2/25/18.
//  Copyright © 2018 Mike Lin. All rights reserved.
//

import UIKit
import Parse

class HomeController: UITableViewController {

    var posts: [PFObject] = []
    
    @IBOutlet weak var logoutButton: UIBarButtonItem!
    
    @IBOutlet weak var newPostButton: UIBarButtonItem!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetchPosts()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }


    func fetchPosts() {
        let query = Post.query()!
        query.order(byDescending: "createdAt")
        query.includeKey("author")
        query.limit = 20
        
        //fetch data asynchronously
        query.findObjectsInBackground(block: {(posts: [PFObject]?, error: Error?) -> Void in
            if let posts = posts {
                self.posts = posts
                print(posts.count)
                self.tableView.reloadData()
            } else {
                print("Data could not be fetched")
            }
        })
        
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return posts.count
    }
    
    @IBAction func logOut(_ sender: Any) {
        PFUser.logOutInBackground(block: { (error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("Successful Logout")
                let loginScreen = UIStoryboard(name: "Main", bundle: nil)
                self.present(loginScreen.instantiateViewController(withIdentifier: "LoginScreen"), animated: false, completion: nil)
            }
        })
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostsTableViewCell
        let post: Post = posts[indexPath.row] as! Post
        cell.userNameLabel.text = post.author.username
        cell.postImage.file = post.picture as? PFFile
        cell.postImage.loadInBackground()
        cell.captionLabel.text = post.caption
        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
