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
                                                  forceCreate: false,
                                                  completionBlock: onAuthenticate,
                                                  errorCompletionBlock: onAuthenticateFailed,
                                                  cbObject: nil)
        }
    }
    
    let reconnectButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(self.reconnectButton)
        if self.traitCollection.userInterfaceStyle == .dark {
            emailTextfield.attributedPlaceholder = NSAttributedString(
                string: "Email",
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
            )
            passwordTextfield.attributedPlaceholder = NSAttributedString(
                string: "Password",
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
            )
        }
        self.reconnectButton.addTarget(self, action: #selector(self.reconnectButtonPressed), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.reconnectButton.frame = CGRect(x: 0, y: 0, width: 250, height: 50)
        self.reconnectButton.setTitle("Reconnect", for: .normal)
        self.reconnectButton.setTitleColor(UIColor(named: "BrandLightBlue"), for: .normal)
        self.reconnectButton.titleLabel?.font = .systemFont(ofSize: 30)
        self.reconnectButton.center = view.center
    }
    
    @objc func reconnectButtonPressed(){
        AppDelegate._bc.reconnect(onAuthenticate, errorCompletionBlock: onAuthenticateFailed, cbObject: nil)
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
