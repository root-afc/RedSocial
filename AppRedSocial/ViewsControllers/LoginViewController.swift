//
//  LoginViewController.swift
//  AppRedSocial
//
//  Created by admin on 10/11/20.
//  Copyright © 2020 Alvaro Fiestas. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController, UITabBarControllerDelegate {

    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var LoginButton: UIButton!
    @IBOutlet weak var ErrorLabel: UILabel!
    
    @IBOutlet weak var RecoverButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
    }
    
    func setUpElements() {
        
        ErrorLabel.alpha = 0
        
        Utilities.styleTextField(EmailTextField)
        Utilities.styleTextField(PasswordTextField)
        Utilities.styleFilledButton(LoginButton)
        Utilities.styleHollowButton(RecoverButton)
    }

    
    func validateFields() -> String? {
        
        if EmailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            PasswordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
        
        {
            return "Por favor, llenar todos los campos."
        }
        
        return nil
    }
    
    
    func monstrarError(_ msg: String)  {
        ErrorLabel.text = msg
        ErrorLabel.alpha = 1
    }
    
    @IBAction func LoginTapped(_ sender: Any) {
        
        let error = validateFields()
        if error != nil {
            monstrarError(error!)
        }
        
        else {
            ErrorLabel.alpha = 0
            let email = EmailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
              let password = PasswordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
              
              Auth.auth().signIn(withEmail: email, password: password) { (result, err) in
                  
                  if err != nil {
                      self.ErrorLabel.text = err!.localizedDescription
                      self.ErrorLabel.alpha = 1
                  }
                  else {
                    let feed = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.feedViewController) as? FeedViewController

                    self.navigationController?.pushViewController(feed!, animated: true)
                  
                }
              }
        }
        
      
    }
    
}
