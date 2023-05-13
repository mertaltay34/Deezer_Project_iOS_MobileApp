//
//  Song.swift
//  Deezer_Project
//
//  Created by Mert Altay on 13.05.2023.
//

import Foundation

struct SongData: Decodable {
    let data: [Song]
}

struct Song: Decodable {
    let title: String?
    let link: String?
    let duration: Int?
    let md5_image: String
    let preview: String?
}
