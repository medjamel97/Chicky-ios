//
//  Musique.swift
//  Chicky
//
//  Created by Mac2021 on 15/11/2021.
//

import Foundation

struct Musique {
    
    internal init(_id: String? = nil, titre: String, artiste: String, credits: String, emplacementFichier: String, emplacementImageAlbum: String) {
        self._id = _id
        self.titre = titre
        self.artiste = artiste
        self.credits = credits
        self.emplacementFichier = emplacementFichier
        self.emplacementImageAlbum = emplacementImageAlbum
    }
    
    var _id : String?
    var titre : String
    var artiste : String
    var credits : String
    var emplacementFichier : String
    var emplacementImageAlbum : String
}
