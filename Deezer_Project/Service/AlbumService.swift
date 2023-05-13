//
//  AlbumService.swift
//  Deezer_Project
//
//  Created by Mert Altay on 13.05.2023.
//

import Foundation
import Alamofire

protocol IAlbumService {
    func fetchAllData(response: @escaping ([DetailedAlbum]?) -> Void)
    
}


struct AlbumService: IAlbumService {
    func fetchAllData(response: @escaping ([DetailedAlbum]?) -> Void) {
        if let tracklist = Singleton.shared.artistTrackList {
            print(tracklist)
            AF.request(tracklist).responseDecodable(of: AlbumData.self) { model in
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
