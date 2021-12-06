//
//  Commentaire.swift
//  Chicky
//
//  Created by Mac2021 on 15/11/2021.
//

import Foundation

struct Commentaire {
    
    let _id : String?
    let description : String?
    let date : Date?
    
    // relations
    let publication : Publication?
    let utilisateur : Utilisateur?
    
}
