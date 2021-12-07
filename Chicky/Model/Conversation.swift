//
//  Conversation.swift
//  Chicky
//
//  Created by Mac2021 on 15/11/2021.
//

import Foundation

struct Conversation {
    internal init(_id: String?=nil, dernierMessage: String?=nil, envoyeur: Utilisateur?=nil, recepteur: Utilisateur?=nil, messages: [Message]?=nil) {
        self._id = _id
        self.dernierMessage = dernierMessage
        self.envoyeur = envoyeur
        self.recepteur = recepteur
        self.messages = messages
    }
    
    
    let _id : String?
    let dernierMessage : String?
    
    // relations
    let envoyeur : Utilisateur?
    let recepteur : Utilisateur?
    let messages: [Message]?
}
