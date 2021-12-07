//
//  Utilisateur.swift
//  Chicky
//
//  Created by Mac-Mini_2021 on 10/11/2021.
//

import Foundation

struct Utilisateur {
    
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
    
    // relations
    var publications : [Publication]?
    var conversations : [Conversation]?
    var commentaires : [Commentaire]?
    var jaimes : [Jaime]?
}
