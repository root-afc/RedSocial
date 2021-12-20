//
//  UsersViewController.swift
//  AppRedSocial
//
//  Created by Alvaro Fiestas on 8/12/20.
//  Copyright © 2020 Alvaro Fiestas. All rights reserved.
//

import UIKit
import Firebase

class UsersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    var currentUID: String = ""
    var fixedUsers: [Dictionary<String, Any>] = []
    var Users_UID:  [String] = []
    @IBOutlet weak var tableview: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.fixedUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userscell", for: indexPath) as! UsersTableViewCell
        let fullName = (self.fixedUsers[indexPath.row]["nombre"] as! String) + " " + (self.fixedUsers[indexPath.row]["apellido"] as! String)
        cell.configure(fullname: fullName)
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        Auth.auth().addStateDidChangeListener { (auth, user) in
            self.currentUID = auth.currentUser!.uid
            self.tableview.rowHeight = UITableView.automaticDimension
            self.loadUsers {
                self.tableview.reloadData()
            }
        }
        
    }

     func loadUsers( completion:  @escaping () -> Void ) {
        let ref = Database.database().reference()
        ref.child("users").child(self.currentUID).child("friends")
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
            self.tableview.reloadData()
            completion()
        }
    }
    

    @IBAction func ProfileClick(_ sender: AnyObject) {
        let buttonPosition:CGPoint = sender.convert(CGPoint.zero, to:self.tableview)
        let indexPath = self.tableview.indexPathForRow(at: buttonPosition)
        let indexUser: Int = indexPath![1] as Int
        let vc = storyboard?.instantiateViewController(identifier: Constants.Storyboard.usersPFController) as? ProfileUsersViewController
        vc?.uidx = self.Users_UID[indexUser]
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}
