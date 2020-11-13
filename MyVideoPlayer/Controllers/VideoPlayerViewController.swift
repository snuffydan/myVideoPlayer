//
//  VideoPlayerViewController.swift
//  MyVideoPlayer
//
//  Created by Danushika Priyadarshani on 11/12/20.
//

import UIKit
import AVKit
import AVFoundation

class VideoPlayerViewController: BaseViewController {
    
    @IBOutlet weak var overlayView: UIView!
    
    var videos: [Video]?
    var videoUrl: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addLogsToFirebase(eventName: GlobalConstants.FirebaseLogEvents.VideoPlayerOpened.rawValue)
        showOverlay()
        getVideos()
    }
    
    private func showOverlay() {
        overlayView.isHidden = false
    }
    
    private func hideOverlay() {
        overlayView.isHidden = true
    }
    
    private func getVideos() {
        if (isConnectedToInternet()) {
            showActivityIndicator()
            
            VideoNetworkManager.getVideos() { (result) in
                self.hideActivityIndicator()
                
                if (result == nil) {
                    self.showAlert(message: GlobalConstants.AlertMessages.ServerError.rawValue)
                } else {
                    if let videos = result?.data {
                        self.videos = videos
                        self.videoUrl = videos[0].url ?? ""
                        self.openVideo()
                    }
                }
            }
        }
    }
    
    private func openVideo() {
        if let url = URL(string: self.videoUrl ?? "") {
            let videoURL = url
            let player = AVPlayer(url: videoURL)
            let playerViewController = AVPlayerViewController()
            playerViewController.delegate = self
            playerViewController.player = player

            present(playerViewController, animated: true) {
                player.play()
                self.hideOverlay()
            }
        }
    }
    
    @IBAction func playVideoAction(_ sender: Any) {
        self.openVideo()
    }
    
    @IBAction func logoutAction(_ sender: Any) {
        let loginVC = UIStoryboard(name: GlobalConstants.Storyboards.Main.rawValue, bundle: nil).instantiateViewController(withIdentifier: GlobalConstants.StoryboardIdentifiers.Login.rawValue) as! LoginViewController
        let navigationController = UINavigationController(rootViewController: loginVC)
        appDelegate.window?.rootViewController = navigationController
        appDelegate.window?.makeKeyAndVisible()
    }
}


extension VideoPlayerViewController: AVPlayerViewControllerDelegate {
    func playerViewController(_ playerViewController: AVPlayerViewController, willBeginFullScreenPresentationWithAnimationCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        print("full screen")
    }
    
    func playerViewControllerDidEndDismissalTransition(_ playerViewController: AVPlayerViewController) {
        print("cancelled and ended")
    }
}
