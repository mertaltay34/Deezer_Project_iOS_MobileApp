//
//  ArtistViewModel.swift
//  Deezer_Project
//
//  Created by Mert Altay on 12.05.2023.
//

import Foundation
 
protocol IArtistViewModel {
    func fetchItems()
    var artistsName: [Artist] {get set}
    var artistService: IArtistService {get}
    var artistOutPut: ArtistOutPut? {get}
    func setDelegate(output: ArtistOutPut)
}


class ArtistViewModel: IArtistViewModel {
    var artistOutPut: ArtistOutPut?
    
    func setDelegate(output: ArtistOutPut) {
        artistOutPut = output
    }
    
    var artistsName: [Artist] = []
    
    var artistService: IArtistService
    init() {
        artistService = ArtistService()
    }
    
    func fetchItems() {
        artistService.fetchAllData { [weak self] response  in
            self?.artistsName = response ?? []
            self?.artistOutPut?.saveData(values: self?.artistsName ?? [])
        }
    }
    

    
}
