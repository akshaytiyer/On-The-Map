//
//  LoginViewController.swift
//  OnTheMap
//
//  Created by Akshay Iyer on 6/28/16.
//  Copyright © 2016 akshaytiyer. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate
{
    //MARK: Properites
    let instance = AppDelegate.sharedInstance()
    
    //MARK: Outets
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        usernameTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    //MARK: Click of login button
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
                if success {
                    self.completeLogin()
                }
                else
                {
                    self.invalidLogin()
                }
                
            })
        }
    }
    
    //MARK: Login invalid alert box
    private func invalidLogin() {
        performUIUpdatesOnMain {
            let alertController = UIAlertController(title: "Invalid Login", message: "Please Enter Your Correct Login Details", preferredStyle: .Alert)
            let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
                self.setUIEnabled(true)
                self.usernameTextField.text = ""
                self.passwordTextField.text = ""
                alertController.dismissViewControllerAnimated(true, completion: nil)
            }
            alertController.addAction(OKAction)
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    //MARK: Login Successful
    private func completeLogin() {
        UdacityClient.sharedInstance().getUdacityUserData(self.instance.udacityData.uniqueKey) { (success, result, errorString) in
            if success
            {
                self.instance.udacityData.firstName = result[UdacityClient.JSONResponseKeys.FirstName] as? String
                self.instance.udacityData.lastName = result[UdacityClient.JSONResponseKeys.LastName] as? String
            }
        }
        performUIUpdatesOnMain {
            self.setUIEnabled(true)
            let controller = self.storyboard!.instantiateViewControllerWithIdentifier("NavigationController") as! UINavigationController
            self.presentViewController(controller, animated: true, completion: nil)
        }
    }
    
    //MARK: Helper methods
    @IBAction func userDidTapView(sender: AnyObject) {
        resignIfFirstResponder(usernameTextField)
        resignIfFirstResponder(passwordTextField)
    }
    
    private func resignIfFirstResponder(textField: UITextField) {
        if textField.isFirstResponder() {
            textField.resignFirstResponder()
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    private func setUIEnabled(enabled: Bool) {
        usernameTextField.enabled = enabled
        passwordTextField.enabled = enabled
    }

    
}
