//
//  SignUpViewController.swift
//  MyVideoPlayer
//
//  Created by Danushika Priyadarshani on 11/13/20.
//

import UIKit

class SignUpViewController: BaseViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        
        // TODO:
        usernameTextField.text = "admin"
        passwordTextField.text = "admin"
    }
    
    private func setUpView() {
        signUpButton.layer.cornerRadius = 5
        signUpButton.layer.borderWidth = 1
        signUpButton.layer.borderColor = UIColor.systemBlue.cgColor
    }

    @IBAction func signUpUser(_ sender: Any) {
        self.addLogsToFirebase(eventName: GlobalConstants.FirebaseLogEvents.UserPressedSignUp.rawValue)
        
        if (usernameTextField.text == "" || passwordTextField.text == "") {
            self.showAlert(message: GlobalConstants.AlertMessages.EnterBothUsernamePassword.rawValue)
        } else {
            saveUserData()
        }
    }
    
    private func saveUserData() {
        let isSaved = CoreDataMethods.saveUserData(username: usernameTextField.text!, password: passwordTextField.text!)
        
        if isSaved {
            self.addLogsToFirebase(eventName: GlobalConstants.FirebaseLogEvents.UserSignedUp.rawValue)
            self.navigationController?.popViewController(animated: false)
        } else {
            self.addLogsToFirebase(eventName: GlobalConstants.FirebaseLogEvents.SignUpError.rawValue)
            self.showAlert(message: GlobalConstants.AlertMessages.SignUpError.rawValue)
        }
    }
}
