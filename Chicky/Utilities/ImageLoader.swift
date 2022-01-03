//
//  ImageLoader.swift
//  Chicky
//
//  Created by Apple Mac on 7/12/2021.
//

import Foundation

import Alamofire

class ImageLoader{
    
    static let shared: ImageLoader = {
        let instance = ImageLoader()
        return instance
    }()
    
    let imageCache = NSCache<NSString,UIImage>()
    let utilityQueue = DispatchQueue.global(qos: .utility)
    
    static let ANNONCE_IMAGE = "ANNONCE_IMAGE"
    static let EVENT_IMAGE = "EVENT_IMAGE"
    
    func loadImage(identifier:String,url:String,completion: @escaping (UIImage?) -> () ) {
        
        if let cachedImage = self.imageCache.object(forKey: NSString(string: identifier)) {
            completion(cachedImage)
        }else{
            utilityQueue.async {
                let url = URL(string: url)!
                
                guard let data = try? Data(contentsOf: url) else {return}
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    self.imageCache.setObject(image!, forKey: NSString(string: identifier))
                    completion (image)
                }
            }
        }
    }
}
