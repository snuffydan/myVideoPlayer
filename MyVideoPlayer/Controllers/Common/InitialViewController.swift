//
//  InitialViewController.swift
//  MyVideoPlayer
//
//  Created by Danushika Priyadarshani on 11/13/20.
//

import UIKit

class InitialViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let loginVC = UIStoryboard(name: GlobalConstants.Storyboards.Main.rawValue, bundle: nil).instantiateViewController(withIdentifier: GlobalConstants.StoryboardIdentifiers.Login.rawValue) as! LoginViewController
        let navigationController = UINavigationController(rootViewController: loginVC)
        appDelegate.window?.rootViewController = navigationController
        appDelegate.window?.makeKeyAndVisible()
    }

}
