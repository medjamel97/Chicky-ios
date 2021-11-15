//
//  MessageTableViewCellViewModel.swift
//  Chicky
//
//  Created by Mac-Mini_2021 on 10/11/2021.
//

import Foundation
import UIKit

struct 	MessageViewModel {
    
    let dernierMessage: String?
    let username: String
    let deleteButton: Bool
    let image: UIImage?
    
    init(with model: Conversation){
        dernierMessage = model.dernierMessage
        username = "Nom & Prenom"
        deleteButton = true
        image = UIImage(named: "image-person")
    }
}
