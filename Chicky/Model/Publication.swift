//
//  Publication.swift
//  Chicky
//
//  Created by Mac2021 on 15/11/2021.
//

import Foundation

struct Publication: Decodable {
    internal init(_id: String?=nil, idPhoto: String?=nil, description: String?=nil, date: Date?=nil, commentaires: [String]?=nil, idUser: String?=nil) {
        self._id = _id
        self.idPhoto = idPhoto
        self.description = description
        self.date = date
        self.commentaires = commentaires
        self.idUser = idUser
    }
    
    
    let _id : String?
    let idPhoto : String?
    let description : String?
    let date : Date?
    let commentaires : [String]?
    let idUser : String?
    
    
}
