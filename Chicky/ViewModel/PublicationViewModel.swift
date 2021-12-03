
//
//  PublicationViewModel.swift
//  Carypark
//
//  Created by Mac-Mini_2021 on 10/11/2021.
//

import SwiftyJSON
import Alamofire
import UIKit.UIImage

class PublicationViewModel {
    
    func getAllPublications(  completed: @escaping (Bool, [Publication]?) -> Void ) {
        AF.request(Constantes.host + "/publication",
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
    
    func getPublication(_id: String?, completed: @escaping (Bool, Publication?) -> Void ) {
        AF.request(Constantes.host + "/publication/",
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
                    let publication = self.makePublication(jsonItem: jsonData["publication"])
                    completed(true, publication)
                case let .failure(error):
                    debugPrint(error)
                    completed(false, nil)
                }
            }
    }
    
    func addPublication(publication: Publication, completed: @escaping (Bool) -> Void ) {
        AF.request(Constantes.host + "/publication/",
                   method: .post,
                   parameters: [
                    "description": publication.description!,
                    "date": publication.date!,
                    "idUser": publication.idUser!,
                    "idPhoto": publication.idPhoto!
                    
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
    
    func editPublication(publication: Publication, completed: @escaping (Bool) -> Void ) {
        AF.request(Constantes.host + "/publication/",
                   method: .put,
                   parameters: [
                    "_id": publication._id!,
                    "description": publication.description!,
                    "date": publication.date!,
                    "idUser": publication.idUser!,
                    "idPhoto": publication.idPhoto!
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
    
    func deletePublication(_id: String?, completed: @escaping (Bool) -> Void ) {
        AF.request(Constantes.host + "/publication/",
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
        Publication (
            
            _id: jsonItem["_id"].stringValue,
            idPhoto: jsonItem["idPhoto"].stringValue,
            description: jsonItem["description"].stringValue,
            date: Date(),
            commentaires: [],
            idUser: jsonItem["idUser"].stringValue
            
            
        )
    }
}
