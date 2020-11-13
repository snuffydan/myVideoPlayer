//
//  VideoNetworkManager.swift
//  MyVideoPlayer
//
//  Created by Danushika Priyadarshani on 11/13/20.
//

import UIKit
import Alamofire

class VideoNetworkManager {
    static func getVideos(completionHandler: @escaping (_ result: Response?) -> Void) {
        
        let headers: HTTPHeaders = ["content-type": "application/json"]
        
        AF.request(GlobalConstants.ServiceUrls.GetVideosUrl.rawValue, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).validate().responseJSON { (response) in switch response.result {
            
        case .success( _):
            if(response.data != nil)
            {
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(Response.self, from:
                        response.data!)
                    print(response)
                    completionHandler(response)
                } catch let parsingError {
                    print("Error", parsingError)
                    completionHandler(nil)
                }
                
            }
            else
            {
                completionHandler(nil)
            }
            
        case .failure(let error):
            print(error.localizedDescription)
            completionHandler(nil)
            }
        }
    }
}
