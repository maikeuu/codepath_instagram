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

    var posts: [Post] = []
    var postIndex: Int?
    
    @IBOutlet weak var logoutButton: UIBarButtonItem!
    
    @IBOutlet weak var newPostButton: UIBarButtonItem!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetchPosts()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        self.tableView.insertSubview(refreshControl, at: 0)
        
        //MARK: For section header
        self.tableView.sectionHeaderHeight = 60
        
    }
    
    @objc func refreshControlAction(_ refreshControl: UIRefreshControl) {
        fetchPosts()
        refreshControl.endRefreshing()
    }
    

    func fetchPosts() {
        let query = Post.query()!
        query.order(byDescending: "createdAt")
        query.includeKey("author")
        query.limit = 20
        
        //fetch data asynchronously
        query.findObjectsInBackground(block: {(posts: [PFObject]?, error: Error?) -> Void in
            if let posts = posts {
                self.posts = posts as! [Post]
                self.tableView.reloadData()
                self.refreshControl?.endRefreshing()
            } else { 
                print("Data could not be fetched")
            }
        })
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        postIndex = indexPath.row
        self.performSegue(withIdentifier: "DetailViewSegue", sender: self)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return posts.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 60))
        let margins = headerView.layoutMarginsGuide
        
        let label = UILabel()
        let imageView = UIImageView()
        
        headerView.addSubview(label)
        headerView.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 2).isActive = true
        imageView.topAnchor.constraint(equalTo: margins.topAnchor, constant: 2).isActive = true
//        imageView.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -2).isActive = true
//        imageView.trailingAnchor.constraint(equalTo: label.leadingAnchor, constant: 0).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 45).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 45).isActive = true
        imageView.image = #imageLiteral(resourceName: "twitter profile pic")
//        imageView.backgroundColor = UIColor.blue
        
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Maikeuu"
        label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8).isActive = true
        label.topAnchor.constraint(equalTo: margins.topAnchor, constant: 0).isActive = true
        label.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: 0).isActive = true
        label.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: 0).isActive = true
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //create a header for every post
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostsTableViewCell
        let post: Post = posts[indexPath.section]
        cell.usernameLabel.text = "Maikeuu"
        cell.usernameLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        cell.postImage.file = post.picture
        cell.postImage.loadInBackground()
        cell.captionLabel.text = post.caption
        return cell
    }
 
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailViewSegue" {
            let destination = segue.destination as! DetailViewController
            let post = posts[postIndex!]
            destination.post = post
        }
    }
}
