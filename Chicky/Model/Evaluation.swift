//
//  Rating.swift
//  Chicky
//
//  Created by Apple Mac on 14/12/2021.
//

import Foundation

struct Evaluation {
    
    var _id: String?
    var note: Int?
    
    // relations
    var publication: Publication?
    var utilisateur: Utilisateur?
    
}
