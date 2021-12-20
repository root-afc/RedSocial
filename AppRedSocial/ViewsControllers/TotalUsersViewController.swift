//
//  TotalUsersViewController.swift
//  AppRedSocial
//
//  Created by Alvaro Fiestas on 9/12/20.
//  Copyright © 2020 Alvaro Fiestas. All rights reserved.
//

import UIKit
import Firebase

class TotalUsersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var currentUID: String = ""
    var fixedUsers: [Dictionary<String, Any>] = []
    var Users_UID:  [String] = []
    @IBOutlet weak var tablevi: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.fixedUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "totaluserscell", for: indexPath) as! TotalUsersTableViewCell
        let fullName = (self.fixedUsers[indexPath.row]["nombre"] as! String) + " " + (self.fixedUsers[indexPath.row]["apellido"] as! String)
        let followers_json = self.fixedUsers[indexPath.row]["followers"] as! NSDictionary
        
        let amount_followers = followers_json.value(forKeyPath: "quantity") as! Int
        
        cell.configure(fullname: fullName, followers: amount_followers)
        
        return cell
    }
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tablevi.rowHeight = UITableView.automaticDimension
        self.loadUsers {
            self.tablevi.reloadData()
        }
       
    }
    
    func loadUsers( completion:  @escaping () -> Void ) {
       let ref = Database.database().reference()
       ref.child("users")
           .observe(DataEventType.value) { (DataSnapshot) in
           if self.fixedUsers.count != 0 || self.Users_UID.count != 0
           {
               self.fixedUsers.removeAll()
               self.Users_UID.removeAll()
           }
          
           for child in DataSnapshot.children.allObjects as! [DataSnapshot] {
               let dict = child.value as! Dictionary<String, Any>
               self.Users_UID.append(child.key)
               self.fixedUsers.append(dict)
           }
           self.tablevi.reloadData()
           completion()
       }
   }
    
    @IBAction func FollowerClick(_ sender: AnyObject) {
        let buttonPosition:CGPoint = sender.convert(CGPoint.zero, to:self.tablevi)
               let indexPath = self.tablevi.indexPathForRow(at: buttonPosition)
               let indexUser: Int = indexPath![1] as Int
               Database.database().reference().child("users").child(self.Users_UID[indexUser]).updateChildValues(["followers" : ["quantity":ServerValue.increment(1)]])
    }
    
}
