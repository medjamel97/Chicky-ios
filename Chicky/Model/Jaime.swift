//
//  Like.swift
//  Geochat
//
//  Created by Mac-Mini_2021 on 10/11/2021.
//

import Foundation

struct Jaime {
    internal init(_id: String? = nil, date: Date? = nil, utilisateur: Utilisateur? = nil, publication: Publication? = nil) {
        self._id = _id
        self.date = date
        self.utilisateur = utilisateur
        self.publication = publication
    }
    
    
    var _id: String?
    var date: Date?
    
    // relations
    var utilisateur: Utilisateur?
    var publication: Publication?
    
}
