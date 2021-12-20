//
//  ProfileUsersViewController.swift
//  AppRedSocial
//
//  Created by Alvaro Fiestas on 9/12/20.
//  Copyright © 2020 Alvaro Fiestas. All rights reserved.
//

import UIKit
import Firebase

class ProfileUsersViewController: UIViewController {

    var uidx: String = ""
    
    
    @IBOutlet weak var NameTextField: UITextField!
    
    @IBOutlet weak var LastNameTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if(user != nil)
                   {
                let ref: DatabaseReference! = Database.database().reference()
                ref.child("users").child(self.uidx)
                    .observeSingleEvent(of: DataEventType.value) { (DataSnapshot) in
                        let dict = DataSnapshot.value as? NSDictionary
                        self.NameTextField.text = dict?.value(forKeyPath: "nombre") as? String
                        self.LastNameTextField.text = dict?.value(forKeyPath: "apellido") as? String
                    }
            }
         }
   
    }

}
