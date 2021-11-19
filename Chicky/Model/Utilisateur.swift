//
//  Utilisateur.swift
//  Chicky
//
//  Created by Mac-Mini_2021 on 10/11/2021.
//

import Foundation

struct Utilisateur: Decodable {
    
    let nom : String?
    let prenom : String?
    let dateNaissance : Date?
    let sexe : Sexe?
    
    init(nom : String?,
         prenom : String?,
         dateNaissance : Date?,
         sexe : Sexe){
        self.nom = "nom"
        self.prenom = "prenom"
        self.dateNaissance = dateNaissance
        self.sexe = sexe
    }
}

enum Sexe: Decodable {
    case masculin, feminin, non_specifié
}
