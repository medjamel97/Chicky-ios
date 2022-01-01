//
//  MusiqueViewModel.swift
//  Carypark
//
//  Created by Mac-Mini_2021 on 10/11/2021.
//

import SwiftyJSON
import Alamofire

class MusiqueViewModel {
    
    static let sharedInstance = MusiqueViewModel()
    
    func recupererTout(completed: @escaping (Bool, [Musique]?) -> Void ) {
        AF.request(HOST_URL + "musique",
                   method: .get)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    var musiques : [Musique]? = []
                    for singleJsonItem in JSON(response.data!)["musiques"] {
                        musiques!.append(self.makeMusique(jsonItem: singleJsonItem.1))
                    }
                    completed(true, musiques)
                case let .failure(error):
                    debugPrint(error)
                    completed(false, nil)
                }
            }
    }
    
    func makeMusique(jsonItem: JSON) -> Musique {
        Musique(
            _id: jsonItem["_id"].stringValue,
            titre: jsonItem["titre"].stringValue,
            artiste: jsonItem["artiste"].stringValue,
            emplacementFichier: jsonItem["emplacementFichier"].stringValue,
            emplacementImageAlbum: jsonItem["emplacementImageAlbum"].stringValue
        )
    }
}
