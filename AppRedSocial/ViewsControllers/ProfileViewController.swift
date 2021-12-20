//
//  ProfileViewController.swift
//  AppRedSocial
//
//  Created by admin on 12/11/20.
//  Copyright © 2020 Alvaro Fiestas. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {

    @IBOutlet weak var nombreTextField: UITextField!
    @IBOutlet weak var apellidoTextField: UITextField!
    @IBOutlet weak var EditNombreButton: UIButton!
    @IBOutlet weak var EditApellidoButton: UIButton!
    @IBOutlet weak var GuardarButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupElements()
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if(user != nil)
                   {
                let ref: DatabaseReference! = Database.database().reference()
                ref.child("users").child(auth.currentUser!.uid)
                    .observeSingleEvent(of: DataEventType.value) { (DataSnapshot) in
                        let dict = DataSnapshot.value as? NSDictionary
                        self.nombreTextField.text = dict?.value(forKeyPath: "nombre") as? String
                        self.apellidoTextField.text = dict?.value(forKeyPath: "apellido") as? String
                    }
            }
         }
    }
    
    
    @IBAction func NombreClick(_ sender: Any) {
        GuardarButton.alpha = 1
        nombreTextField.isUserInteractionEnabled = true
        nombreTextField.becomeFirstResponder()
    }
    
    
    @IBAction func ApellidoClick(_ sender: Any) {
        GuardarButton.alpha = 1
        apellidoTextField.isUserInteractionEnabled = true
        apellidoTextField.becomeFirstResponder()
    }
    
    
    @IBAction func GuardarClick(_ sender: Any) {
        GuardarButton.alpha = 0
        nombreTextField.isUserInteractionEnabled = false
        apellidoTextField.isUserInteractionEnabled = false
        Auth.auth().addStateDidChangeListener { (auth, user) in
            let ref: DatabaseReference! = Database.database().reference()
            ref.child("users").child(auth.currentUser!.uid).updateChildValues(["nombre" : self.nombreTextField.text!, "apellido" : self.apellidoTextField.text!])
        }
    }
    
    func setupElements()
    {
        GuardarButton.alpha = 0
        Utilities.styleHollowButton(GuardarButton)
    }
    
}
