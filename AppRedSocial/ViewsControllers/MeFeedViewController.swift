//
//  MeFeedViewController.swift
//  AppRedSocial
//
//  Created by Alvaro Fiestas on 8/12/20.
//  Copyright © 2020 Alvaro Fiestas. All rights reserved.
//

import UIKit
import Firebase

class MeFeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var user_uid = ""
    var fixedposts : [Dictionary<String, AnyObject>] = []
    var key_post : [String] = []
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.fixedposts.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: Constants.Storyboard.commentViewController) as? CommentsViewController
        vc?.modalPresentationStyle = .popover
        vc?.uid = key_post[indexPath.row]
        self.present(vc!, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celdatwo", for: indexPath) as! MeFeedTableViewCell
        
        let fxposts = fixedposts[indexPath.row]["comment"] as! String
        let fxfullname = fixedposts[indexPath.row]["full_name"] as! String
        let quantityLikes = self.fixedposts[indexPath.row]["likes"] as! NSDictionary
        let resultLikes: Int = quantityLikes.value(forKey: "quantity") as! Int
        
        cell.configure(comments: fxposts, fullname: fxfullname, quantity: resultLikes)
        
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
  
        Auth.auth().addStateDidChangeListener { (auth, user) in
            self.user_uid = auth.currentUser!.uid
            self.tableView.rowHeight = UITableView.automaticDimension
            self.loadFeed {
                self.tableView.reloadData()
            }
        }
    }
    
    
    func loadFeed( completion:  @escaping () -> Void ) {
        
        var ref: DatabaseReference!
        ref = Database.database().reference().child("posts")
        ref.queryOrdered(byChild: "owner_uid").queryEqual(toValue: self.user_uid)
        .observe(DataEventType.value) { (snapshot) in
            if self.fixedposts.count != 0
            {
                self.fixedposts.removeAll()
            }
            if self.key_post.count != 0
            {
                self.key_post.removeAll()
            }
            for child in snapshot.children.allObjects as! [DataSnapshot] {
                self.key_post.append(child.key)
             let dict = child.value as! Dictionary <String, AnyObject>
                self.fixedposts.append(dict)
             }
           
            self.tableView.reloadData()
            completion()
        }
    }
    
    
    @IBAction func NewPostClick(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: Constants.Storyboard.postViewController) as? PostViewController
        vc?.modalPresentationStyle = .popover
        self.present(vc!, animated: true, completion: nil)
    }
    
    
    @IBAction func LikeClick(_ sender: AnyObject) {
        let buttonPosition:CGPoint = sender.convert(CGPoint.zero, to:self.tableView)
        let indexPath = self.tableView.indexPathForRow(at: buttonPosition)
        let indexPost: Int = indexPath![1] as Int
        Database.database().reference().child("posts").child(self.key_post[indexPost]).updateChildValues(["likes" : ["quantity":ServerValue.increment(1)]])
    }
    
    
    @IBAction func DeletePostClick(_ sender: AnyObject) {
        let buttonPosition:CGPoint = sender.convert(CGPoint.zero, to:self.tableView)
        let indexPath = self.tableView.indexPathForRow(at: buttonPosition)
        let indexPost: Int = indexPath![1] as Int
        Database.database().reference().child("posts").child(self.key_post[indexPost]).removeValue()
    }
}
