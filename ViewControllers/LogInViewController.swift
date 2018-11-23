//
//  LogInViewController.swift
//  MapMe
//
//  Created by Adam Rikardsen-Smith on 18/11/2018.
//  Copyright © 2018 Adam Rikardsen-Smith. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LogInViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signUpLogInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tap = UITapGestureRecognizer(target: self, action: #selector(handleScreenTap(sender:)))
        self.view.addGestureRecognizer(tap)
        self.view.bindToKeyboard()
    }
    
    @objc func handleScreenTap(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    

    @IBAction func signUpLogInButtonWasPressed(_ sender: Any) {
        if emailField.text != nil && passwordField.text != nil {
            
            self.view.endEditing(true)
            
            if let email = emailField.text, let password = passwordField.text {
                Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                    if error == nil {
                        if let user = user {
                          
                            let userData = ["provider": user.user.providerID] as [String: Any]
                                DataService.instance.createFirebaseDBUser(uid: user.user.uid, userData: userData)
                            }
                        self.showMapViewController()
                    } else {
                        if let errorCode = AuthErrorCode(rawValue: error!._code) {
                            switch errorCode {
                            case .wrongPassword:
                                self.showErrorAlert(ERROR_MSG_WRONG_PASSWORD)
                            case .userNotFound: print("user not found is not an error")
                            default:
                                self.showErrorAlert(ERROR_MSG_UNEXPECTED_ERROR)
                            }
                        }
                        
                        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                            if error != nil {
                                if let errorCode = AuthErrorCode(rawValue: error!._code) {
                                    switch errorCode {
                                    case .invalidEmail:
                                        self.showErrorAlert(ERROR_MSG_INVALID_EMAIL)
                                    default:
                                        self.showErrorAlert(ERROR_MSG_UNEXPECTED_ERROR)
                                    }
                                }
                            } else {
                                if let user = user {
                                    let userData = ["provider": user.user.providerID] as [String: Any]
                                        DataService.instance.createFirebaseDBUser(uid: user.user.uid, userData: userData)
                                    
                                }
                                self.showMapViewController()
                            }
                        })
                    }
                })
            }
        }
    }
    
    func showMapViewController(){
        performSegue(withIdentifier: "MapSegue", sender: nil)
    }

    func showErrorAlert(_ msg: String) {
        let alertController = UIAlertController(title: "Error:", message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MapSegue"{
            if let controller = segue.destination as? MapViewController{
                
            }
        }
    }
}
