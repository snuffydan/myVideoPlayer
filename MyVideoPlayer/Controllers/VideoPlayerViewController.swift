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
    
    @IBOutlet weak var videoView: UIView!
    
    var videos: [Video]?
    var isVideoShown = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addLogsToFirebase(eventName: GlobalConstants.FirebaseLogEvents.VideoPlayerOpened.rawValue)
        
        getVideos()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if isVideoShown {
            self.navigationController?.popViewController(animated: false)
        }
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
                        self.openVideo(videoUrl: videos[0].url ?? "")
                    }
                }
            }
        }
    }
    
    private func openVideo(videoUrl: String) {
        if let url = URL(string: videoUrl) {
            let videoURL = url
            let player = AVPlayer(url: videoURL)
            let playerViewController = AVPlayerViewController()
            playerViewController.delegate = self
            playerViewController.player = player

            present(playerViewController, animated: true) {
                player.play()
            }
            
            
//            let asset = AVAsset(url: url)
//            let playerItem = AVPlayerItem(asset: asset)
//            let player = AVPlayer(playerItem: playerItem)
//
//            let playerLayer = AVPlayerLayer(player: player)
//            playerLayer.frame = self.videoView.bounds
//            playerLayer.videoGravity = .resizeAspect
//            self.videoView.layer.addSublayer(playerLayer)
//            player.play()
        }
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
