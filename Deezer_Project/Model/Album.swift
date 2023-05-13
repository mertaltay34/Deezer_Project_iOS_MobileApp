//
//  Album.swift
//  Deezer_Project
//
//  Created by Mert Altay on 13.05.2023.
//

import Foundation

struct AlbumData: Decodable {
    let data: [Album]
}

struct Album: Decodable {
    let id: Int
    let title: String
    let link: String
    let cover: String
    let cover_small: String
    let cover_medium: String
    let cover_big: String
    let cover_xl: String
    let release_date: String
}

