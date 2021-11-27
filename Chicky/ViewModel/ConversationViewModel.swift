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
        
    init(){}
    
    typealias DownloadComplete =
    
    func recupererConversation(completed: @escaping (Bool, Any?) -> Void) {
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
    
    func manipulerConversation(conversation: Conversation?, methode:HTTPMethod, completed: @escaping DownloadComplete) {
        AF.request(Constantes.host + "/conversation",
                   method: methode,
                   parameters: ["idPhoto": conversation!._id, "nom": conversation!.nom])
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
    
    func supprimerConversation(email: String, mdp: String, completed: @escaping DownloadComplete) {
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
    
    func makeItem(jsonItem: JSON) -> Utilisateur {
        //let isoDate = jsonItem["dateNaissance"]
        /*let isoDate = "2016-04-14T10:44:00+0000"
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from:isoDate)!*/
        
        return Conversation(_id: jsonItem["_id"].stringValue, nom: jsonItem["nom"].stringValue)
    }
}
