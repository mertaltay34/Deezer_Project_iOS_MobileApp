//
//  ArtistViewModel.swift
//  Deezer_Project
//
//  Created by Mert Altay on 12.05.2023.
//

import Foundation
 
protocol IArtistViewModel {
    func fetchItems()
    var artistNames: [Artist] {get set}
    var artistService: IArtistService {get}
    var artistOutPut: ArtistOutPut? {get}
    func setDelegate(output: ArtistOutPut)
}


class ArtistViewModel: IArtistViewModel {
    var artistOutPut: ArtistOutPut?
    
    func setDelegate(output: ArtistOutPut) {
        artistOutPut = output
    }
    
    var artistNames: [Artist] = []
    
    var artistService: IArtistService
    init() {
        artistService = ArtistService()
    }
    
    func fetchItems() {
        artistService.fetchAllData { [weak self] response  in
            self?.artistNames = response ?? []
            self?.artistOutPut?.saveData(values: self?.artistNames ?? [])
        }
    }
    

    
}
