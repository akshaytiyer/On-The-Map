//
//  LoginViewController.swift
//  OnTheMap
//
//  Created by Akshay Iyer on 6/28/16.
//  Copyright © 2016 akshaytiyer. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController
{
    
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBAction func loginPressed(sender: AnyObject) {
        userDidTapView(self)
        if usernameTextField.text!.isEmpty || passwordTextField.text!.isEmpty {
            print("Username or Password Empty.")
        } else {
            setUIEnabled(false)
            let loginParameter: [String: String!] =
                ["Username": usernameTextField.text,
                 "Password": passwordTextField.text]
            UdacityClient.sharedInstance().authenticateWithViewController(self,loginParameters: loginParameter,completionHandlerForAuth: { (success, errorString) in
                self.completeLogin()
            })
        }
    }
    
    private func completeLogin() {
        performUIUpdatesOnMain {
            self.setUIEnabled(true)
            let controller = self.storyboard!.instantiateViewControllerWithIdentifier("NavigationController") as! UINavigationController
            self.presentViewController(controller, animated: true, completion: nil)
        }
    }
    
    @IBAction func userDidTapView(sender: AnyObject) {
        resignIfFirstResponder(usernameTextField)
        resignIfFirstResponder(passwordTextField)
    }
    
    private func resignIfFirstResponder(textField: UITextField) {
        if textField.isFirstResponder() {
            textField.resignFirstResponder()
        }
    }
    
    private func setUIEnabled(enabled: Bool) {
        usernameTextField.enabled = enabled
        passwordTextField.enabled = enabled
    }

    
}
