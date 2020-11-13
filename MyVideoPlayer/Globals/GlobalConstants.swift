//
//  GlobalConstants.swift
//  MyVideoPlayer
//
//  Created by Danushika Priyadarshani on 11/12/20.
//

import UIKit

class GlobalConstants {
    
    enum AlertMessages: String {
        case EnterBothUsernamePassword = "Please enter both your Username and Password."
        case ServerError = "Server error occured. Please try again later."
        case NoNetworkError = "No Network Found."
    }
    
    enum ServiceUrls: String {
        case GetVideosUrl = "https://run.mocky.io/v3/190d8388-923c-4a41-8439-289728f1ab4c"
    }
    
    enum Storyboards: String {
        case Main = "Main"
    }
    
    enum StoryboardIdentifiers: String {
        case Login = "loginVC"
        case VideoPlayer = "videoPlayerVC"
    }
    
    enum FirebaseLogEvents: String {
        case UserPressedLogIn = "User_Pressed_Log_In_Button"
        case UserLoggedIn = "User_Logged_In"
        case VideoPlayerOpened = "Video_Player_Opened"
    }

}
