//
//  ViewController.swift
//  Expenses
//
//  Created by sumit prasad on 25/07/18.
//  Copyright © 2018 Philips. All rights reserved.
//

import UIKit
import Firebase
// BG Color code FF6D3D
class ViewController: UIViewController {
    
    let loginToList = "LoginToList"

    @IBOutlet weak var txtEmailId: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        Auth.auth().addStateDidChangeListener() { auth, user in
            if user != nil {
                self.performSegue(withIdentifier: self.loginToList, sender: nil)
                self.txtEmailId.text = nil
                self.txtPassword.text = nil
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func signInAction(_ sender: Any) {
        guard checkCredentialFields() == true else {
            return
        }
        if let email = txtEmailId.text, let password = txtPassword.text{
        Auth.auth().signIn(withEmail: email, password: password) { user, error in
                if let error = error, user == nil {
                    let alert = UIAlertController(title: "Sign In Failed",
                                              message: error.localizedDescription,
                                              preferredStyle: .alert)
                
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                
                    self.present(alert, animated: true, completion: nil)
                } else{
                    self.performSegue(withIdentifier: self.loginToList, sender: nil)
                }
            }
        }
    }
    
    @IBAction func registerAction(_ sender: Any) {
        guard checkCredentialFields() == true else {
            return
        }
        if let email = txtEmailId.text, let password = txtPassword.text{
            Auth.auth().createUser(withEmail: email, password: password) { user, error in
                if error == nil {
                    Auth.auth().signIn(withEmail: email,
                                       password: password) { user, error in
                                        if let error = error, user == nil {
                                            let alert = UIAlertController(title: "Sign In Failed",
                                                                          message: error.localizedDescription,
                                                                          preferredStyle: .alert)
                                            
                                            alert.addAction(UIAlertAction(title: "OK", style: .default))
                                            
                                            self.present(alert, animated: true, completion: nil)
                                        }
                    }
                }
            }
        }
    }
}

extension ViewController {
    func checkCredentialFields() -> Bool{
        if let email = txtEmailId.text, email.count > 0, let password = txtPassword.text, password.count > 0 {
            return true
        } else {
            let alert = UIAlertController.init(title: "Error", message: "Please enter valid email id and password", preferredStyle: .alert)
           let action = UIAlertAction.init(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
            return false
        }
    }
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtEmailId {
            txtPassword.becomeFirstResponder()
        }
        if textField == txtPassword {
            textField.resignFirstResponder()
        }
        return true
    }
}


