//
//  Publication.swift
//  Chicky
//
//  Created by Mac2021 on 15/11/2021.
//

import Foundation

struct Publication {
    
    let _id : String?
    let idPhoto : String?
    let description : String?
    let date : Date?
    
    // relations
    let commentaires : [Commentaire]?
    let utilisateur : Utilisateur?
    
}
