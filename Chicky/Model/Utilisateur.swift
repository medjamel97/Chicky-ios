//
//  Utilisateur.swift
//  Chicky
//
//  Created by Mac-Mini_2021 on 10/11/2021.
//

import Foundation

struct Utilisateur: Encodable {

    var _id : String?
    var pseudo : String?
    var email : String?
    var mdp  : String?
    var nom : String?
    var prenom : String?
    var dateNaissance : Date?
    var idPhoto : String?
    var sexe : Bool?
    var score : Int?
    var bio : String?
    var isVerified : Bool?
    
    internal init(_id: String? = nil, pseudo: String? = nil, email: String? = nil, mdp: String? = nil, nom: String? = nil, prenom: String? = nil, dateNaissance: Date? = nil, idPhoto: String? = nil, sexe: Bool? = nil, score: Int? = nil, bio: String? = nil, isVerified: Bool? = nil) {
        self._id = _id
        self.pseudo = pseudo
        self.email = email
        self.mdp = mdp
        self.nom = nom
        self.prenom = prenom
        self.dateNaissance = dateNaissance
        self.idPhoto = idPhoto
        self.sexe = sexe
        self.score = score
        self.bio = bio
        self.isVerified = isVerified
    }
    
    internal init(pseudo: String? = nil, email: String? = nil, mdp: String? = nil, nom: String? = nil, prenom: String? = nil, dateNaissance: Date? = nil, idPhoto: String? = nil, sexe: Bool? = nil, score: Int? = nil, bio: String? = nil, isVerified: Bool? = nil) {
        self.pseudo = pseudo
        self.email = email
        self.mdp = mdp
        self.nom = nom
        self.prenom = prenom
        self.dateNaissance = dateNaissance
        self.idPhoto = idPhoto
        self.sexe = sexe
        self.score = score
        self.bio = bio
        self.isVerified = isVerified
    }
    
}
