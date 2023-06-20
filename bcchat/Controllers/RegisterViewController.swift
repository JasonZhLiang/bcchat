//
//  RegisterViewController.swift
//  bcchat
//
//  Created by Jason Liang on 2023-06-10.
//

import UIKit
import AuthenticationServices

class RegisterViewController: UIViewController {

    @IBOutlet weak var loginErrorLabel: UILabel!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBAction func registerPressed(_ sender: UIButton) {
        if let email = emailTextfield.text, let password = passwordTextfield.text {
            AppDelegate._bc.authenticateEmailPassword(email,
                                                  password: password,
                                                  forceCreate: true,
                                                  completionBlock: onAuthenticate,
                                                  errorCompletionBlock: onAuthenticateFailed,
                                                  cbObject: nil)
        }
    }
    
    let signInButton = ASAuthorizationAppleIDButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(signInButton)
        signInButton.addTarget(self, action: #selector(signInButtonPressed), for: .touchUpInside)
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
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        signInButton.frame = CGRect(x: 0, y: 0, width: 250, height: 50)
        signInButton.center = view.center
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
        self.performSegue(withIdentifier: "registerToChannel", sender: self)
    }
    
    func onAuthenticateFailed(serviceName:String?, serviceOperation:String?, statusCode:Int?, reasonCode:Int?, jsonError:String?, cbObject: NSObject?) {
        print("\(serviceOperation!) Failure \(jsonError!)")
        self.loginErrorLabel.text = "\n\(serviceOperation!) Error \(reasonCode!)"
        UserDefaults.standard.set(false, forKey: "HasAuthenticated")
    }
    
    //MARK: - apple signIn
    
    @objc func signInButtonPressed() {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }
}

//MARK: - ASAuthorizationControllerDelegate

extension RegisterViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("ASAuthorizationController Failure didCompleteWithError \(error)")
        self.loginErrorLabel.text = "Apple SignIn with Error \(error)"
    }
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let credentails as ASAuthorizationAppleIDCredential:
            let userIdentifier = credentails.user
            print(userIdentifier)
            let fullName = credentails.fullName
            let email = credentails.email
            let token = String(data:credentails.identityToken!, encoding:.utf8)
            print(token as Any)
            AppDelegate._bc.authenticateApple(userIdentifier, identityToken: token, forceCreate: true, completionBlock: onAuthenticate, errorCompletionBlock: onAuthenticateFailed, cbObject: nil)
        default:
            break
        }
    }
}

//MARK: - ASAuthorizationControllerPresentationContextProviding

extension RegisterViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window!
    }
}
