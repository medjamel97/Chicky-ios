//
//  File.swift
//  Chicky
//
//  Created by Apple Mac on 1/1/2022.
//

import Foundation
import Alamofire

class AudioLoader{
    
    static let sharedInstance = AudioLoader()
    
    func loadMusic(url:String,completion: @escaping (URL?) -> () ) {
        
        let destination = DownloadRequest.suggestedDownloadDestination(for: .documentDirectory, in: .userDomainMask, options: .removePreviousFile)
        AF.download(
            url,
            method: .get,
            to: destination)
            .downloadProgress(closure: { (progress) in
                print(progress)
            }).response(completionHandler: { (DefaultDownloadResponse) in
                print(DefaultDownloadResponse)
                completion(DefaultDownloadResponse.fileURL)
            })
    }
}
