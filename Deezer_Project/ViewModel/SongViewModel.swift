//
//  SongViewModel.swift
//  Deezer_Project
//
//  Created by Mert Altay on 14.05.2023.
//

import Foundation

protocol ISongViewModel {
    func fetchItems()
    var songs: [Song] { get set }
    var songService: ISongService { get }
    var songOutPut: SongOutPut? { get }
    func setDelegate(output: SongOutPut)
}


class SongViewModel: ISongViewModel {
    
    var songOutPut: SongOutPut?
    
    func setDelegate(output: SongOutPut) {
        songOutPut = output
    }
    
    var songs: [Song] = []
    
    let songService: ISongService
    
    init() {
        songService = SongService()
    }
    
    func fetchItems() {
        songService.fetchAllData { [weak self] (response) in
            self?.songs = response ?? []
            self?.songOutPut?.saveData(values: self?.songs ?? [])
        }
    }
    
    
}
