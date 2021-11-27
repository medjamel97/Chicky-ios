//
//  MessageViewModel.swift
//  Chicky
//
//  Created by User on 26/11/2021.
//

import Foundation
import SwiftyJSON
import Alamofire

public class MessageViewModel: ObservableObject{
    	
    init(){}
    
    typealias DownloadComplete = (Bool) -> ()
    
    func recupererMessage(completed: @escaping DownloadComplete) {
        AF.request(Constantes.host + "/message",
                   method: .get)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    print("recupererMessage : Validation Successful")
                    completed(true)
                case let .failure(error):
                    print(error)
                    completed(false)
                }
            }
    }
    
    func manipulerMessage(message: Message?, methode:HTTPMethod, completed: @escaping DownloadComplete) {
        AF.request(Constantes.host + "/message",
                   method: methode,
                   parameters: ["idPhoto": message!.idPhoto, "description": message!.description])
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    print("manipulerMessage : Validation Successful")
                    completed(true)
                case let .failure(error):
                    print(error)
                    completed(false)
                }
            }
    }
    
    func supprimerMessage(email: String, mdp: String, completed: @escaping DownloadComplete) {
        AF.request(Constantes.host + "/message", method: .delete)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    print("supprimerMessage : Validation Successful")
                    completed(true)
                case let .failure(error):
                    print(error)
                    completed(false)
                }
            }
    }
}
