//
//  Message.swift
//  Chicky
//
//  Created by Mac2021 on 15/11/2021.
//

import Foundation
import MessageKit

struct Sender: SenderType {
    var senderId: String
    var displayName: String
}

struct Message : MessageType {
    var sender: SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKind
    
    // relations
    //var conversationEnvoyeur : Conversation
    //var conversationRecepteur : Conversation
}
