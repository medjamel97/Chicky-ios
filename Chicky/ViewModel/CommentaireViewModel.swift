//
//  CommentaireViewModel.swift
//  Carypark
//
//  Created by Mac-Mini_2021 on 10/11/2021.
//

import SwiftyJSON
import Alamofire
import UIKit.UIImage

class CommentaireViewModel {
    
    func getAllCommentaires(idPublication: String?,  completed: @escaping (Bool, [Commentaire]?) -> Void ) {
        AF.request(Constantes.host + "commentaire/all",
                   method: .get/*,
                  parameters: [
                   "idPublication": idPublication!
                   ]*/)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    let jsonData = JSON(response.data!)
                    
                    var commentaires : [Commentaire]? = []
                    for singleJsonItem in jsonData["commentaire"] {
                        commentaires!.append(self.makeCommentaire(jsonItem: singleJsonItem.1))
                    }
                    completed(true, commentaires)
                case let .failure(error):
                    debugPrint(error)
                    completed(false, nil)
                }
            }
    }
    
    func getCommentaire(_id: String?, completed: @escaping (Bool, Commentaire?) -> Void ) {
        AF.request(Constantes.host + "commentaire/",
                   method: .get,
                   parameters: [
                    "_id": _id!
                   ])
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    let jsonData = JSON(response.data!)
                    let commentaire = self.makeCommentaire(jsonItem: jsonData["commentaire"])
                    completed(true, commentaire)
                case let .failure(error):
                    debugPrint(error)
                    completed(false, nil)
                }
            }
    }
    
    func addCommentaire(commentaire: Commentaire, completed: @escaping (Bool) -> Void ) {
        AF.request(Constantes.host + "commentaire/",
                   method: .post,
                   parameters: [
                    "description": commentaire.description!,
                    "date": commentaire.date!,
                   ])
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    completed(true)
                case let .failure(error):
                    debugPrint(error)
                    completed(false)
                }
            }
    }
    
    func editCommentaire(commentaire: Commentaire, completed: @escaping (Bool) -> Void ) {
        AF.request(Constantes.host + "commentaire/",
                   method: .put,
                   parameters: [
                    "_id": commentaire._id!,
                    "description": commentaire.description!,
                    "date": commentaire.date!
                   ])
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    completed(true)
                case let .failure(error):
                    debugPrint(error)
                    completed(false)
                }
            }
    }
    
    func deleteCommentaire(_id: String?, completed: @escaping (Bool) -> Void ) {
        AF.request(Constantes.host + "commentaire/",
                   method: .delete,
                   parameters: [
                    "_id": _id!
                    
                   ])
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    completed(true)
                case let .failure(error):
                    debugPrint(error)
                    completed(false)
                }
            }
    }
    
    func makeCommentaire(jsonItem: JSON) -> Commentaire {
        Commentaire(
            _id: jsonItem["_id"].stringValue,
            description: jsonItem["description"].stringValue,
            date: Date()
                   
        )
    }
}
