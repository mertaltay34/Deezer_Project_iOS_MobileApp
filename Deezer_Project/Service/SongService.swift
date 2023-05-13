//
//  SongService.swift
//  Deezer_Project
//
//  Created by Mert Altay on 14.05.2023.
//

import Foundation
import Alamofire

protocol ISongService {
    func fetchAllData(response: @escaping ([Song]?) -> Void)
    
}


struct SongService: ISongService {
    func fetchAllData(response: @escaping ([Song]?) -> Void) {
        if let albumId = Singleton.shared.albumId {
            AF.request("https://api.deezer.com/album/\(albumId)/tracks").responseDecodable(of: SongData.self) { model in
                print(albumId)
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
