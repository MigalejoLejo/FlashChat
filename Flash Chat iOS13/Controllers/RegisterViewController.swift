//
//  RegisterViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var warningLabel: UILabel!
    
   
    
    override func viewDidAppear(_ animated: Bool) {
        warningLabel.text = ""
        emailTextfield.textColor = .none
        passwordTextfield.textColor = .none
    }
    
    
    @IBAction func registerPressed(_ sender: UIButton) {
        if let email = emailTextfield.text, let password = passwordTextfield.text {
            if emailIsValid() && passwordIsValid() {
                self.warningLabel.text = "✅ Registering..."

                
                Auth.auth().createUser(withEmail: email, password: password) { response, error in
                    if let e = error {
                        self.warningLabel.text = "🙁 A problem ocurred:" + "\n" + "\(e.localizedDescription)"
                    }
                    
                    if let _ = response {
                        Warning.setBorder(for: self.emailTextfield, to: .good)
                        Warning.setBorder(for: self.passwordTextfield, to: .good)
                        self.warningLabel.text = "🖖 Welcome on board"
                        self.performSegue(withIdentifier: K.registerSegue, sender: self)
                    }
                }
                
                
                
            } else if !emailIsValid() && !passwordIsValid(){
                warningLabel.text = "⚠️ invalid email and password"
                Warning.setBorder(for: emailTextfield, to: .bad)
                Warning.setBorder(for: passwordTextfield, to: .bad)
                
            } else if !emailIsValid() {
                warningLabel.text = "⚠️ invalid email"
                Warning.setBorder(for: emailTextfield, to: .bad)
                Warning.setBorder(for: passwordTextfield, to: .good)
            } else if !passwordIsValid() {
                warningLabel.text = "⚠️ Password must contain at least 1 lower case, 1 upper case, 1 number and 1 special character, and it must be at least 6 characters long "
                Warning.setBorder(for: emailTextfield, to: .good)
                Warning.setBorder(for: passwordTextfield, to: .bad)
            }
        }
    }
    
    
    func emailIsValid() -> Bool {
            let emailRegEx = "^[\\w\\.-]+@([\\w\\-]+\\.)+[A-Z]{1,4}$"
            let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
            return emailTest.evaluate(with: emailTextfield.text!)
    }
    
    func passwordIsValid() -> Bool {
            let passwordRegEx = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[d$@$!%*?&#])[A-Za-z\\dd$@$!%*?&#]{6,}"
            let passwordTest = NSPredicate(format:"SELF MATCHES[c] %@", passwordRegEx)
            return passwordTest.evaluate(with: passwordTextfield.text!)
    }
    
}





