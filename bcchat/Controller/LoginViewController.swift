//
//  LoginViewController.swift
//  bcchat
//
//  Created by Jason Liang on 2023-06-09.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBAction func loginPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "loginToChannel", sender: self)
    }
}
