//
//  Conversation.swift
//  Chicky
//
//  Created by Mac2021 on 15/11/2021.
//

import Foundation

struct Conversation : Decodable {
    
    let _id : String?
    let nom : String?
    
    internal init(_id: String?, nom: String?) {
        self._id = _id
        self.nom = nom
    }
    
}
