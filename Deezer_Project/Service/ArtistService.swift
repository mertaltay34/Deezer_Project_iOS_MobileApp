//
//  ArtistService.swift
//  Deezer_Project
//
//  Created by Mert Altay on 11.05.2023.
//

import Foundation
import Alamofire

var categoryId: Int?


protocol IArtistService {
    func fetchAllData(response: @escaping ([Artist]?) -> Void)
    
}


struct ArtistService: IArtistService {
    func fetchAllData(response: @escaping ([Artist]?) -> Void) {
        if let id = Singleton.shared.artistCategoryId {
            AF.request("https://api.deezer.com/genre/\(id)/artists").responseDecodable(of: ArtistData.self) { model in
                guard let results = model.value else {
                    response(nil)
                    return
                }
                response(results.data)
                
            }
        } else {
            // err
            print("error")
        }

    }

}

