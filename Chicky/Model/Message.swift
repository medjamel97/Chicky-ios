//
//  Message.swift
//  Chicky
//
//  Created by Mac2021 on 15/11/2021.
//

struct Message : Decodable{
    
    let contenu: String?
    
    init(contenu: String?){
        self.contenu = contenu
    }
}
