
//
//  PublicationViewModel.swift
//  Carypark
//
//  Created by Mac-Mini_2021 on 10/11/2021.
//

import SwiftyJSON
import Alamofire
import UIKit.UIImage
import Foundation

class PublicationViewModel {
    
    static let sharedInstance = PublicationViewModel()
    
    func recupererToutPublication(  completed: @escaping (Bool, [Publication]?) -> Void ) {
        AF.request(Constantes.host + "publication",
                   method: .get)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    let jsonData = JSON(response.data!)
                    
                    var publications : [Publication]? = []
                    for singleJsonItem in jsonData["publication"] {
                        publications!.append(self.makePublication(jsonItem: singleJsonItem.1))
                    }
                    completed(true, publications)
                case let .failure(error):
                    debugPrint(error)
                    completed(false, nil)
                }
            }
    }
    
    func recupererMesPublication(  completed: @escaping (Bool, [Publication]?) -> Void ) {
        AF.request(Constantes.host + "publication/mes",
                   method: .post,
                   parameters: [
                    "user": UserDefaults.standard.string(forKey: "idUtilisateur")!
                   ])
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    let jsonData = JSON(response.data!)
                    
                    var publications : [Publication]? = []
                    for singleJsonItem in jsonData["publication"] {
                        publications!.append(self.makePublication(jsonItem: singleJsonItem.1))
                    }
                    completed(true, publications)
                case let .failure(error):
                    debugPrint(error)
                    completed(false, nil)
                }
            }
    }
    
    func ajouterPublication(publication: Publication, videoUrl: URL, completed: @escaping (Bool) -> Void ) {
        
        AF.upload(multipartFormData: { multipartFormData in
            
            do {
                let data = try Data(contentsOf: videoUrl, options: .mappedIfSafe)
                
                multipartFormData.append(data, withName: "video" , fileName: "video.mp4", mimeType: "video/mp4")
                //  here you can see data bytes of selected video, this data object is upload to server by multipartFormData upload
            } catch  {
            }
            
            for (key, value) in
                    [
                        "user": UserDefaults.standard.string(forKey: "idUtilisateur")!,
                        "description": publication.description!
                    ]
            {
                multipartFormData.append((value.data(using: .utf8))!, withName: key)
            }
            
        },to: Constantes.host + "publication/",
                  method: .post)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    print("Success")
                    completed(true)
                case let .failure(error):
                    completed(false)
                    print(error)
                }
            }
    }
    
    func modifierPublication(publication: Publication, completed: @escaping (Bool) -> Void ) {
        AF.request(Constantes.host + "publication/",
                   method: .put,
                   parameters: [
                    "_id": publication._id!,
                    "idPhoto": publication.idPhoto!,
                    "description": publication.description!,
                    "date": publication.date!,
                    "utilisateur": publication.utilisateur!._id!
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
    
    func supprimerPublication(_id: String?, completed: @escaping (Bool) -> Void ) {
        AF.request(Constantes.host + "publication/",
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
    
    func makePublication(jsonItem: JSON) -> Publication {
        var commentaires: [Commentaire] = []
        for i in jsonItem["commentaires"] {
            commentaires.append(makeCommentaire(jsonItem: i.1))
        }
        var jaimes: [Jaime] = []
        for j in jsonItem["jaimes"]{
            jaimes.append(makeJaime(jsonItem: j.1))
        }
        return Publication(
            _id: jsonItem["_id"].stringValue,
            idPhoto: jsonItem["idPhoto"].stringValue,
            description: jsonItem["description"].stringValue,
            date: Date(),
            commentaires: commentaires,
            utilisateur: makeUtilisateur(jsonItem: jsonItem["utilisateur"]),
            jaimes: jaimes
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
    
    func makeCommentaire(jsonItem: JSON) -> Commentaire {
        Commentaire(
            _id: jsonItem["_id"].stringValue, description: jsonItem["description"].stringValue, date: Date()
        )
    }
    func makeJaime(jsonItem: JSON) -> Jaime {
        Jaime(_id: jsonItem["_id"].stringValue, date: Date())
    }
}
