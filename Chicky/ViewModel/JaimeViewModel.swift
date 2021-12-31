//
//  LikeViewModel.swift
//  Geochat
//
//  Created by Mac-Mini_2021 on 10/11/2021.
//

import SwiftyJSON
import Alamofire
import UIKit.UIImage

class JaimeViewModel {
    
    static let sharedInstance = JaimeViewModel()
    
    func makeJaime(jsonItem: JSON) -> Jaime {
        var publications: [Publication] = []
        for i in jsonItem["commentaire"] {
            publications.append(makePublication(jsonItem: i.1))
        }
        return Jaime(
            _id: jsonItem["_id"].stringValue,
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
        Publication(_id: jsonItem["_id"].stringValue)
    }
    
    
    
    
    
    func getMyLikes(completed: @escaping (Bool, [Jaime]?) -> Void ) {
      /*  AF.request(Constantes.host + "/like/my",
                   method: .post,
                   parameters: [
                    "liked": UserDefaults.standard.string(forKey: "userId")!
                   ])
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    var likes : [Like]? = []
                    for singleJsonItem in JSON(response.data!)["likes"] {
                        likes!.append(self.makeLike(jsonItem: singleJsonItem.1))
                    }
                    completed(true, likes)
                case let .failure(error):
                    debugPrint(error)
                    completed(false, nil)
                }
            }*/
    }
    /*
    func getLikeById(_id: String?, completed: @escaping (Bool, Like?) -> Void ) {
        AF.request(Constantes.host + "/like/by-id",
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
                    let like = self.makeLike(jsonItem: jsonData["like"])
                    completed(true, like)
                case let .failure(error):
                    print(error)
                    completed(false, nil)
                }
            }
    }
    
    func addLike(like: Like, completed: @escaping (Bool) -> Void ) {
        AF.request(Constantes.host + "/like",
                   method: .post,
                   parameters: [
                    "seen": like.seen!,
                    "liker": UserDefaults.standard.string(forKey: "userId")!,
                    "liked": like.liked!._id!
                   ])
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    completed(true)
                case let .failure(error):
                    print(error)
                    completed(false)
                }
            }
    }
    
    func editLike(like: Like, completed: @escaping (Bool) -> Void ) {
        AF.request(Constantes.host + "/like/",
                   method: .put,
                   parameters: [
                    "_id": like._id!,
                    "clickDate": like.clickDate!,
                    "seen": like.seen!
                   ])
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    completed(true)
                case let .failure(error):
                    print(error)
                    completed(false)
                }
            }
    }
    
    func deleteLike(_id: String?, completed: @escaping (Bool) -> Void ) {
        AF.request(Constantes.host + "/like/del",
                   method: .post,
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
                    print(error)
                    completed(false)
                }
            }
    }
    
    func makeJaime(jsonItem: JSON) -> Jaime {
        Jaime(
            _id: jsonItem["_id"].stringValue,
             clickDate: Date(), //jsonItem["clickDate"].stringValue,
            seen: jsonItem["seen"].boolValue
            
        )
    }
    
    func makeUtilisateur(jsonItem: JSON) -> Utilisateur {
        return Utilisateur(
            _id: jsonItem["_id"].stringValue,
            email: jsonItem["email"].stringValue,
            password: jsonItem["password"].stringValue,
            firstname: jsonItem["firstname"].stringValue,
            lastname: jsonItem["lastname"].stringValue,
            age: jsonItem["age"].intValue,
            sexe: jsonItem["sexe"].stringValue,
            location: jsonItem["location"].stringValue,
            isVerified: jsonItem["isVerified"].boolValue
        )
    }*/
    

    
    
    
}
