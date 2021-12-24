//
//  ImageLoader.swift
//  Chicky
//
//  Created by Apple Mac on 7/12/2021.
//

import Foundation

import Alamofire

class VideoLoader{
    
    static let sharedInstance: VideoLoader = {
        let instance = VideoLoader()
        return instance
    }()
    
    func loadVideo( identifier:String, url:String, completion: @escaping (Bool, String?) -> () ) {
        
        let destination: DownloadRequest.Destination = { _, _ in
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileURL = documentsURL.appendingPathComponent("video.mp4")
            
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }
        
        AF.download("https://httpbin.org/image/png", to: destination)
            .downloadProgress(queue: .main, closure: { (progress) in
                //progress closure
                print(progress.fractionCompleted)
            })
            .response { response in
                debugPrint(response)
                
                if response.error == nil, let filePath = response.fileURL?.path {
                    print(filePath)
                    completion(true, filePath)
                } else {
                    completion(false, nil)
                }
            }
    }
}
