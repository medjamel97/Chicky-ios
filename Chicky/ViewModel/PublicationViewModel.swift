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
    
    func recupererPublication(completed: @escaping DownloadComplete) {
        AF.request(Constantes.host + "/publication",
                   method: .get)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    print("recupererPublication : Validation Successful")
                    completed(true)
                case let .failure(error):
                    print(error)
                    completed(false)
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
}
