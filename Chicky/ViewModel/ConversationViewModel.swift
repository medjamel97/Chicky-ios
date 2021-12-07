//
//  ConversationViewModel.swift
//  Chicky
//
//  Created by User on 26/11/2021.
//

import Foundation
import SwiftyJSON
import Alamofire

public class ConversationViewModel: ObservableObject{
    
    
    func getAllConversation(completed: @escaping (Bool, [Conversation]?) -> Void ) {
        AF.request(Constantes.host + "/conversation/",
                   method: .get)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    var conversations : [Conversation]? = []
                    for singleJsonItem in JSON(response.data!)["conversations"] {
                        conversations!.append(self.makeItem(jsonItem: singleJsonItem.1))
                    }
                    completed(true, conversations)
                case let .failure(error):
                    debugPrint(error)
                    completed(false, nil)
                }
            }
    }
    
    func recupererConversations(completed: @escaping (Bool, Any?) -> Void) {
        AF.request(Constantes.host + "/conversation",
                   method: .get)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    let jsonData = JSON(response.data!)
                    let conversation = self.makeItem(jsonItem: jsonData["conversation"])
                    print("recupererConversation : Validation Successful")
                    completed(true, conversation)
                case let .failure(error):
                    print(error)
                    completed(false, nil)
                }
            }
    }
    
    func manipulerConversation(conversation: Conversation?, methode:HTTPMethod, completed: @escaping (Bool) -> Void ) {
        AF.request(Constantes.host + "/conversation",
                   method: methode,
                   parameters: ["idPhoto": conversation!._id, "nom": conversation!.dernierMessage])
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    print("manipulerConversation : Validation Successful")
                    completed(true)
                case let .failure(error):
                    print(error)
                    completed(false)
                }
            }
    }
    
    func supprimerConversation(email: String, mdp: String, completed: @escaping (Bool) -> Void) {
        AF.request(Constantes.host + "/conversation", method: .delete)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    print("supprimerConversation : Validation Successful")
                    completed(true)
                case let .failure(error):
                    print(error)
                    completed(false)
                }
            }
    }
    
    func suppConversation(_id: String?, completed: @escaping (Bool) -> Void) {
        AF.request(Constantes.host + "/conversation", method: .delete)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    print("supprimerConversation : Validation Successful")
                    completed(true)
                case let .failure(error):
                    print(error)
                    completed(false)
                }
            }
    }
    
    
    
    func makeItem(jsonItem: JSON) -> Conversation {
        //let isoDate = jsonItem["dateNaissance"]
        /*let isoDate = "2016-04-14T10:44:00+0000"
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from:isoDate)!*/
        
        return Conversation(
            _id: jsonItem["_id"].stringValue,
            dernierMessage: jsonItem["dernierMessage"].stringValue,
            envoyeur: makeUtilisateur(jsonItem: jsonItem["envoyeur"]),
            recepteur: makeUtilisateur(jsonItem: jsonItem["recepteur"])
        )
    }
    
    func makeUtilisateur(jsonItem: JSON) -> Utilisateur {

        return Utilisateur(
            _id: jsonItem["_id"].stringValue,
            pseudo: jsonItem["pseudo"].stringValue,
            email: jsonItem["email"].stringValue,
            mdp: jsonItem["mdp"].stringValue,
            nom: jsonItem["nom"].stringValue,
            prenom: jsonItem["prenom"].stringValue,
            dateNaissance: Date(),
            idPhoto: jsonItem["idPhoto"].stringValue,
            sexe: jsonItem["sexe"].boolValue,
            score: jsonItem["score"].intValue,
            bio: jsonItem["bio"].stringValue,
            isVerified: jsonItem["isVerified"].boolValue
        )
    }
    
    
    
}
