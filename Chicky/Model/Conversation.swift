//
//  Conversation.swift
//  Chicky
//
//  Created by Mac2021 on 15/11/2021.
//

import Foundation

struct Conversation {
    
    internal init(_id: String? = nil, dernierMessage: String, dateDernierMessage: Date, envoyeur: Utilisateur, recepteur: Utilisateur) {
        self._id = _id
        self.dernierMessage = dernierMessage
        self.dateDernierMessage = dateDernierMessage
        self.envoyeur = envoyeur
        self.recepteur = recepteur
    }
    
    var _id : String?
    var dernierMessage : String
    var dateDernierMessage : Date
    
    // relations
    var envoyeur : Utilisateur
    var recepteur : Utilisateur
}
