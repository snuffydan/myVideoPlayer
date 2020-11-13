//
//  BaseViewController.swift
//  MyVideoPlayer
//
//  Created by Danushika Priyadarshani on 11/12/20.
//

import UIKit
import Firebase

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func isConnectedToInternet() -> Bool {
        do {
            let reachability = try Reachability()
            
            if reachability.connection == .unavailable {
                showAlert(message: GlobalConstants.AlertMessages.NoNetworkError.rawValue)
                return false
            } else {
                return true
            }
            
        } catch let error {
            fatalError(error.localizedDescription)
        }
    }
    
    func showAlert(title: String? = "Error!", message: String, btnTitle: String? = "OK") {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: btnTitle, style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func addLogsToFirebase(eventName: String) {
        Analytics.logEvent(eventName, parameters: nil)
    }
    
    func addLogsToFirebaseWithParameters(eventName: String, parameterName: String, parameterValue: String) {
        Analytics.logEvent(eventName, parameters: [
            parameterName: parameterValue as NSObject
        ])
    }
    
    func showActivityIndicator() {
        ActivityIndicator.start()
    }
    
    func hideActivityIndicator() {
        ActivityIndicator.stop()
    }
}
