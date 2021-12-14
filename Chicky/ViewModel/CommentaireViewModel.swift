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
    
    func recupererCommentaireParPublication(idPublication: String?,  completed: @escaping (Bool, [Commentaire]?) -> Void ) {
        AF.request(Constantes.host + "commentaire/par-publication",
                   method: .post,
                   parameters: [
                    "publication": idPublication!
                   ], encoding: JSONEncoding.default)
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
    
    func ajouterCommentaire(idPublication: String, commentaire: Commentaire, completed: @escaping (Bool) -> Void ) {
        AF.request(Constantes.host + "commentaire",
                   method: .post,
                   parameters: [
                    "description": commentaire.description!,
                    "date": DateUtils.formatFromDate(date: commentaire.date!),
                    "publication": idPublication,
                    "utilisateur": UserDefaults.standard.string(forKey: "idUtilisateur")!
                   ], encoding: JSONEncoding.default)
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
    
    func modifierCommentaire(commentaire: Commentaire, completed: @escaping (Bool) -> Void ) {
        AF.request(Constantes.host + "commentaire",
                   method: .put,
                   parameters: [
                    "_id": commentaire._id!,
                    "description": commentaire.description!
                   ], encoding: JSONEncoding.default)
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
    
    func supprimerCommentaire(_id: String?, completed: @escaping (Bool) -> Void ) {
        AF.request(Constantes.host + "commentaire",
                   method: .delete,
                   parameters: [
                    "_id": _id!
                    
                   ], encoding: JSONEncoding.default)
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
            date: DateUtils.formatFromString(string: jsonItem["date"].stringValue),
            publication: makePublication(jsonItem: jsonItem["publication"]),
            utilisateur: makeUtilisateur(jsonItem: jsonItem["utilisateur"])
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
    
    func makePublication(jsonItem: JSON) -> Publication {
        return Publication(
            _id: jsonItem["_id"].stringValue,
            idPhoto: jsonItem["idPhoto"].stringValue,
            description: jsonItem["description"].stringValue,
            date: DateUtils.formatFromString(string: jsonItem["date"].stringValue)
        )
    }
}
