//
//  LoginViewController.swift
//  bcchat
//
//  Created by Jason Liang on 2023-06-09.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var loginErrorLabel: UILabel!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBAction func loginPressed(_ sender: UIButton) {
        if let email = emailTextfield.text, let password = passwordTextfield.text {
            AppDelegate._bc.authenticateEmailPassword(email,
                                                  password: password,
                                                  forceCreate: true,
                                                  completionBlock: onAuthenticate,
                                                  errorCompletionBlock: onAuthenticateFailed,
                                                  cbObject: nil)
        }
    }
    
    func onAuthenticate(serviceName:String?, serviceOperation:String?, jsonData:String?, cbObject: NSObject?) {
        print("\(serviceOperation!) Success \(jsonData!)")
        
        let data = jsonData?.data(using: String.Encoding.utf8, allowLossyConversion: false)!
        
        do {
            let json = try JSONSerialization.jsonObject(with: data!, options: []) as! [String: AnyObject]
            
            let data = json["data"] as AnyObject;
            let isNewUser = data["newUser"] as! String;
            
            if(isNewUser.elementsEqual("true")) {
                AppDelegate._bc.playerStateService.updateName(self.emailTextfield?.text,
                                                              completionBlock: nil,
                                                              errorCompletionBlock: nil,
                                                              cbObject: nil)
            }
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        }
        
        UserDefaults.standard.set(true, forKey: "HasAuthenticated")
        self.performSegue(withIdentifier: "loginToChannel", sender: self)
    }
    
    func onAuthenticateFailed(serviceName:String?, serviceOperation:String?, statusCode:Int?, reasonCode:Int?, jsonError:String?, cbObject: NSObject?) {
        print("\(serviceOperation!) Failure \(jsonError!)")
        
        if(reasonCode == 40208) {
            self.loginErrorLabel.text = "Account does not exist. Please register instead."
        } else {
            self.loginErrorLabel.text = "\n\(serviceOperation!) Error \(reasonCode!)"
            print("this is loginErrorLabel text: \(self.loginErrorLabel.text!)")
        }
        
        UserDefaults.standard.set(false, forKey: "HasAuthenticated")
    }
}
