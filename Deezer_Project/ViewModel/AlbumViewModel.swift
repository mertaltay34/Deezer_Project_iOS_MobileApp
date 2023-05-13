//
//  AlbumViewModel.swift
//  Deezer_Project
//
//  Created by Mert Altay on 13.05.2023.
//

import Foundation

protocol IAlbumViewModel {
    func fetchItems()
    var albums: [DetailedAlbum] { get set }
    var albumService: IAlbumService { get }
    var albumOutPut: AlbumOutPut? { get }
    func setDelegate(output: AlbumOutPut)
}


class AlbumViewModel: IAlbumViewModel {
    var albumOutPut: AlbumOutPut?
    
    func setDelegate(output: AlbumOutPut) {
        albumOutPut = output
    }
    
    var albums: [DetailedAlbum] = []
    
    let albumService: IAlbumService
    
    init() {
        albumService = AlbumService()
    }
    
    func fetchItems() {
        albumService.fetchAllData { [weak self] (response) in
            self?.albums = response ?? []
            self?.albumOutPut?.saveData(values: self?.albums ?? [])
        }
    }
    
    
}
