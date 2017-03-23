//
//  ViewController.swift
//  Avishek
//
//  Created by framgia on 10/17/16.
//  Copyright © 2016 framgia. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    // MARK: - Properties
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var getHelpLabel: UILabel!
    @IBOutlet weak var signingInLabel: UILabel!
    @IBOutlet weak var facebookLoginLabel: UILabel!
    @IBOutlet weak var signUpLabel: UILabel!
    
    var user = User(username: "", password: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // load user credentials
        if let savedUser = User.loadUser() {
            user = savedUser
        }
        
        if(user?.username != ""){
            usernameTextField.text = user?.username
        }
        
        if(user?.password != ""){
            passwordTextField.text = user?.password
        }
        
        let getHelpGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.forgotPassword(_:)))
        getHelpLabel.isUserInteractionEnabled = true
        getHelpLabel.addGestureRecognizer(getHelpGestureRecognizer)
        
        let signingInGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.forgotPassword(_:)))
        signingInLabel.isUserInteractionEnabled = true
        signingInLabel.addGestureRecognizer(signingInGestureRecognizer)
        
        let facebookLoginGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.loginWithFacebook(_:)))
        facebookLoginLabel.isUserInteractionEnabled = true
        facebookLoginLabel.addGestureRecognizer(facebookLoginGestureRecognizer)
        
        let signUpGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.signUp(_:)))
        signUpLabel.isUserInteractionEnabled = true
        signUpLabel.addGestureRecognizer(signUpGestureRecognizer)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == usernameTextField {
            passwordTextField.becomeFirstResponder()
        } else {
            passwordTextField.resignFirstResponder()
        }
        
        return true
    }
    
    // MARK: - Actions
    
    @IBAction func login(_ sender: AnyObject) {
        if(isValid()){
            showAlert(title: "Success!", message: "Login successful!", okCompletion: {
                let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "TableViewNavigationController") as! UINavigationController
                self.present(secondViewController, animated: true)
            })
            
            // get user credentials from textFields and save
            user = User(username: usernameTextField.text!, password: passwordTextField.text!)
            User.saveUser(user: self.user!)
        }
    }
    
    func forgotPassword(_ sender: UITapGestureRecognizer) {
        showAlert(title: "Not available", message: "", okCompletion: {})
    }
    
    func loginWithFacebook(_ sender: UITapGestureRecognizer) {
        showAlert(title: "Not available", message: "", okCompletion: {})
    }
    
    func signUp(_ sender: UITapGestureRecognizer) {
        showAlert(title: "Not available", message: "", okCompletion: {})
    }
    
    // MARK: - Validation
    
    func isValid() -> Bool {
        var username = usernameTextField.text
        var password = passwordTextField.text
        
        if(username?.isEmpty)!{
            showAlert(title: "Username empty!", message: "Username cannot be empty.", okCompletion: {})
            return false
        }
        
        if(password?.isEmpty)!{
            showAlert(title: "Password empty!", message: "Password cannot be empty.", okCompletion: {})
            return false
        }
        
        if((username?.characters.count)! < 6){
            showAlert(title: "Invalid username!", message: "Username must be at least 6 characters long.", okCompletion: {})
            return false
        }
        
        if((password?.characters.count)! < 8){
            showAlert(title: "Invalid password", message: "Password must be at least 8 characters long.", okCompletion: {})
            return false
        }
        
        return true;
    }
    
    // MARK: - Alert
    
    func showAlert(title: String, message: String, okCompletion: @escaping () -> ()){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { UIAlertAction in
            okCompletion()
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

