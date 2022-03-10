//
//  LoginViewController.swift
//  Flash Chat iOS13
//
//  Created by saeem  on 28/02/22.
//  Copyright © 2022 Saeem. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    

    @IBAction func loginPressed(_ sender: UIButton) {
        if let email = emailTextfield.text, let password = passwordTextfield.text {
        
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let e = error {
                print(e)
            } else {
                self.performSegue(withIdentifier: "LoginToChat", sender: self) // This will take us to the chat view screen.
            }
         
          // ...
           }
        }
     }
    
}
