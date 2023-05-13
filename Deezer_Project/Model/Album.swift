//
//  Album.swift
//  Deezer_Project
//
//  Created by Mert Altay on 13.05.2023.
//

import Foundation

struct AlbumData: Decodable {
    let data: [DetailedAlbum]
}

struct DetailedAlbum: Decodable {
    let id: Int
    let title: String
    let link: String
    let preview: String
    let contributors: [Contributor]
    let album: Album
}

struct Contributor: Decodable {
    let picture_medium: String
}

struct Album: Decodable {
    let id: Int
    let title: String
    let cover_medium: String
    let tracklist: String
    
}
