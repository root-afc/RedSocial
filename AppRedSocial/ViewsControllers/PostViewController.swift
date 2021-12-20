//
//  PostViewController.swift
//  AppRedSocial
//
//  Created by Alvaro Fiestas on 29/11/20.
//  Copyright © 2020 Alvaro Fiestas. All rights reserved.
//

import UIKit
import Firebase

class PostViewController: UIViewController {
    
    @IBOutlet weak var labelError: UILabel!
    var FullName : String = ""
    var uid : String = ""
    @IBOutlet weak var PostButton: UIButton!
    @IBOutlet weak var CommentPostTextField: UITextView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelError.alpha = 0
        setUpElements()
    }
    
    func setUpElements(){
        Utilities.styleUITextField(CommentPostTextField)
    }

    @IBAction func PostClick(_ sender: Any) {
        
        if(CommentPostTextField.text.count < 3)
        {
            labelError.alpha = 1
            labelError.text = "Ingresar por lo menos 3 letras."
           
        }
        else
        {
            labelError.alpha = 0
            postComment()
            dismiss(animated: true, completion: nil)
        }
        
    }
    
    
   func postComment()
   {
    Auth.auth().addStateDidChangeListener { (auth, user) in
        
        if(user != nil)
            
               {
                
        let ref = Database.database().reference()
            ref.child("users").child(auth.currentUser!.uid)
                .observeSingleEvent(of: DataEventType.value) { (DataSnapshot) in
                    let dict = DataSnapshot.value as? NSDictionary
                    self.FullName = (dict?.value(forKeyPath: "nombre") as! String) + " " + (dict?.value(forKeyPath: "apellido") as! String)
                    self.uid = auth.currentUser!.uid
                    
                    let ref: DatabaseReference! = Database.database().reference()
                    ref.child("posts").childByAutoId().setValue(["comment": self.CommentPostTextField.text! as NSString, "full_name": self.FullName as NSString, "owner_uid": self.uid as NSString, "likes": ["quantity":0] as NSDictionary])
                }
               
               
            }
        }
    
 }
}
