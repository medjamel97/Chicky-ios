//
//  MessageViewModel.swift
//  Chicky
//
//  Created by Mac-Mini_2021 on 10/11/2021.
//

import SwiftyJSON
import Alamofire
import UIKit.UIImage

public class MessageViewModel {
    
    init(){
    }
    
    struct Root : Decodable {
        let results: [Message]
    }
    
}
