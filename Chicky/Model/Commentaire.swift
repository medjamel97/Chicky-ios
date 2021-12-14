//
//  Commentaire.swift
//  Chicky
//
//  Created by Mac2021 on 15/11/2021.
//

import Foundation

struct Commentaire {
    
    internal init(_id: String? = nil, description: String?, date: Date?, publication: Publication? = nil, utilisateur: Utilisateur? = nil) {
        self._id = _id
        self.description = description
        self.date = date
        self.publication = publication
        self.utilisateur = utilisateur
    }
    
    
    let _id : String?
    var description : String?
    let date : Date?
    
    // relations
    let publication : Publication?
    let utilisateur : Utilisateur?
    
}
