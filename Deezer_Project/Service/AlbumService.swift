//
//  AlbumService.swift
//  Deezer_Project
//
//  Created by Mert Altay on 13.05.2023.
//

import Foundation
import Alamofire

protocol IAlbumService {
    func fetchAllData(response: @escaping ([Album]?) -> Void)
    
}


struct AlbumService: IAlbumService {
    func fetchAllData(response: @escaping ([Album]?) -> Void) {
        if let artistId = Singleton.shared.artistId {
            AF.request("https://api.deezer.com/artist/\(artistId)/albums").responseDecodable(of: AlbumData.self) { model in
                print(artistId)
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
