//
//  Enregistrement.swift
//  Chicky
//
//  Created by Apple Mac on 2/1/2022.
//

import Foundation

struct Enregistrement {
    
    internal init(_id: String? = nil, lieu: String, date: Date? = nil, utilisateur: Utilisateur? = nil) {
        self._id = _id
        self.lieu = lieu
        self.date = date
        self.utilisateur = utilisateur
    }
    
    var _id: String?
    var lieu: String
    var date: Date?
    var utilisateur: Utilisateur?
    
}
