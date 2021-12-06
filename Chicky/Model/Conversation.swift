//
//  Conversation.swift
//  Chicky
//
//  Created by Mac2021 on 15/11/2021.
//

import Foundation

struct Conversation {
    
    let _id : String?
    let nom : String?
    
    // relations
    let envoyeur : Utilisateur?
    let recepteur : Utilisateur?
}
