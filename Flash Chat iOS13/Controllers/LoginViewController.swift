//
//  LoginViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import FirebaseAuth
import CLTypingLabel

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var warningLabel: UILabel!
    
    override func viewDidLoad() {
        self.warningLabel.text = ""


    }
    
    @IBAction func loginPressed(_ sender: UIButton) {

        
        if let email = emailTextfield.text, let password = passwordTextfield.text {
            Auth.auth().signIn(withEmail: email, password: password){ response, error in
                if let e = error {
                    self.warningLabel.text = "Login Error: \(e.localizedDescription)"
                }
                
                if let _ = response {
                    Warning.setBorder(for: self.emailTextfield, to: .good)
                    Warning.setBorder(for: self.passwordTextfield, to: .good)
                    self.warningLabel.text = ""
                    self.performSegue(withIdentifier: K.loginSegue, sender: self)
                }
            }
        }
    }
    
}
