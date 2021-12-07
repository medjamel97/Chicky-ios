//
//  Publication.swift
//  Chicky
//
//  Created by Mac2021 on 15/11/2021.
//

import Foundation

struct Publication {
    internal init(_id: String?=nil, idPhoto: String?=nil, description: String?=nil, date: Date?=nil, commentaires: [Commentaire]?=nil, utilisateur: Utilisateur?=nil, jaimes: [Jaime]?=nil) {
        self._id = _id
        self.idPhoto = idPhoto
        self.description = description
        self.date = date
        self.commentaires = commentaires
        self.utilisateur = utilisateur
        self.jaimes = jaimes
    }
    
    
    let _id : String?
    let idPhoto : String?
    let description : String?
    let date : Date?
    
    // relations
    let commentaires : [Commentaire]?
    let utilisateur : Utilisateur?
    let jaimes: [Jaime]?
    
}
