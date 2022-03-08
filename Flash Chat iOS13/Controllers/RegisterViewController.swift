//
//  RegisterViewController.swift
//  Flash Chat iOS13
//
//  Created by saeem  on 28/02/22.
//  Copyright © 2022 Saeem. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBAction func registerPressed(_ sender: UIButton) {
        
        if  let email = emailTextfield.text, let password = passwordTextfield.text{
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let e = error {
                print(e.localizedDescription) // This will display error in the language user has specified in their phone.
            } else {
                // Navigate to chat view controller. through segue
                self.performSegue(withIdentifier: "RegisterToChat", sender: self)
            }
             }
        }
        
    }
    
}
