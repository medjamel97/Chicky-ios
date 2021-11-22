//
//  Message.swift
//  Chicky
//
//  Created by Mac2021 on 15/11/2021.
//

import Foundation

struct Message : Decodable{
    
    let _id: String?
    let description: String?
    
    internal init(_id: String?, description: String?) {
        self._id = _id
        self.description = description
    }
    
}
