//
//  LoginViewController.swift
//  MyVideoPlayer
//
//  Created by Danushika Priyadarshani on 11/12/20.
//

import UIKit
import Firebase

class LoginViewController: BaseViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        
        // TODO:
        usernameTextField.text = "admin"
        passwordTextField.text = "admin"
    }
    
    private func setUpView() {
        loginButton.layer.cornerRadius = 5
        loginButton.layer.borderWidth = 1
        loginButton.layer.borderColor = UIColor.systemBlue.cgColor
    }
    
    @IBAction func loginUser(_ sender: Any) {
        self.addLogsToFirebase(eventName: GlobalConstants.FirebaseLogEvents.UserPressedLogIn.rawValue)
        
        if (usernameTextField.text == "" || passwordTextField.text == "") {
            self.showAlert(message: GlobalConstants.AlertMessages.EnterBothUsernamePassword.rawValue)
        } else {
            let users = CoreDataMethods.getUserData()
            
            for user in users {
                if (user.username == usernameTextField.text && user.password == passwordTextField.text) {
                    let videoPlayerVC = UIStoryboard(name: GlobalConstants.Storyboards.Main.rawValue, bundle: nil).instantiateViewController(withIdentifier: GlobalConstants.StoryboardIdentifiers.VideoPlayer.rawValue) as! VideoPlayerViewController
                    let navigationController = UINavigationController(rootViewController: videoPlayerVC)
                    appDelegate.window?.rootViewController = navigationController
                    appDelegate.window?.makeKeyAndVisible()
                    
                    self.addLogsToFirebaseWithParameters(eventName: GlobalConstants.FirebaseLogEvents.UserLoggedIn.rawValue, parameterName: "username", parameterValue: usernameTextField.text!)
                } else {
                    showAlert(message: GlobalConstants.AlertMessages.InvalidCredentials.rawValue)
                }
            }
        }
    }
    
    @IBAction func signupUser(_ sender: Any) {
        let signUpVC = UIStoryboard(name: GlobalConstants.Storyboards.Main.rawValue, bundle: nil).instantiateViewController(withIdentifier: GlobalConstants.StoryboardIdentifiers.SignUp.rawValue) as! SignUpViewController
        signUpVC.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(signUpVC, animated: true)
    }
}
