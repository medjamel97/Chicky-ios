//
//  UtilisateurViewModel.swift
//  Chicky
//
//  Created by Mac-Mini_2021 on 10/11/2021.
//

import SwiftyJSON
import Alamofire
import UIKit.UIImage

public class PublicationViewModel: ObservableObject{
    
    init(){}
    
    typealias DownloadComplete = (Bool) -> ()
    
    
    func getPublications(completed: @escaping (Bool, [Publication]?) -> Void) {
        AF.request(Constantes.host + "/publication",
                   method: .get)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    let jsonData = JSON(response.data!)
                    debugPrint(jsonData)
                    
                    var publications : [Publication]? = []
                    debugPrint(jsonData["publication"])
                    for singleJsonItem in jsonData["publication"] {
                        publications!.append(self.makeItem(jsonItem: singleJsonItem.1))
                    }
                    completed(true, publications)
                case let .failure(error):
                    print(error)
                    completed(false, nil)
                }
            }
    }
    
    func manipulerPublication(publication: Publication?, methode:HTTPMethod, completed: @escaping DownloadComplete) {
        AF.request(Constantes.host + "/publication",
                   method: methode,
                   parameters: ["idPhoto": publication!.idPhoto, "description": publication!.description])
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    print("manipulerPublication : Validation Successful")
                    completed(true)
                case let .failure(error):
                    print(error)
                    completed(false)
                }
            }
    }
    
    func supprimerPublication(email: String, mdp: String, completed: @escaping DownloadComplete) {
        AF.request(Constantes.host + "/publication", method: .delete)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    print("supprimerPublication : Validation Successful")
                    completed(true)
                case let .failure(error):
                    print(error)
                    completed(false)
                }
            }
    }
    
    func makeItem(jsonItem: JSON) -> Publication {
        Publication(
            _id: jsonItem["_id"].stringValue,
            idPhoto: jsonItem["idPhoto"].stringValue,
            description: jsonItem["description"].stringValue,
            date: Date()
        )
    }
}
