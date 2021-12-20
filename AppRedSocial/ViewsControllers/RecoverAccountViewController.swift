//
//  RecoverAccountViewController.swift
//  AppRedSocial
//
//  Created by admin on 10/11/20.
//  Copyright © 2020 Alvaro Fiestas. All rights reserved.
//

import UIKit
import Firebase

class RecoverAccountViewController: UIViewController {

    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var EmailButton: UIButton!
    @IBOutlet weak var MensajeLabel: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        MensajeLabel.alpha = 0
        Utilities.styleTextField(EmailTextField)
        Utilities.styleHollowButton(EmailButton)
        
    }
    

    func ValidateTextField() -> String? {
        if EmailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
        {
            return "Por favor, llene el campo."
        }
        return nil
    }
    
    
    func monstrarError(_ msg: String)  {
        MensajeLabel.text = msg
        MensajeLabel.alpha = 1
    }
    
    
    
    @IBAction func RecuperarCuenta(_ sender: Any) {
        
        let error = ValidateTextField()
        
        if(error != nil) {
            monstrarError(error!)
        }
        
        else {
            let email = EmailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            Auth.auth().sendPasswordReset(withEmail: email) { (err) in
                if err != nil {

                    self.MensajeLabel.text = "El email ingresado no está registrado u ocurrió un error."
                    self.MensajeLabel.alpha = 1
                }
                else {
                    self.MensajeLabel.text = "Se envió un enlace al correo para reestablecer la contraseña."
                   
                    self.MensajeLabel.alpha = 1
                }
            }
        }
        
    }
    
}
