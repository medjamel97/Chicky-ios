//
//  Publication.swift
//  Chicky
//
//  Created by Mac2021 on 15/11/2021.
//

import Foundation

struct Publication: Decodable {
    
    let _id : String?
    let idPhoto : String?
    let description : String?
    let date : Date?
    
    internal init(_id: String?, idPhoto: String?, description: String?, date: Date?) {
        self._id = _id
        self.idPhoto = idPhoto
        self.description = description
        self.date = date
    }
    
}
