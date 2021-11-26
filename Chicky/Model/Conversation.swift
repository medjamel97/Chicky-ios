//
//  Conversation.swift
//  Chicky
//
//  Created by Mac2021 on 15/11/2021.
//

import Foundation

struct Conversation : Decodable {
    
    let _id : String?
    
    internal init(_id: String?) {
        self._id = _id
    }
    
}
