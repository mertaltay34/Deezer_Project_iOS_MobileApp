//
//  Artist.swift
//  Deezer_Project
//
//  Created by Mert Altay on 11.05.2023.
//

import Foundation
struct ArtistData: Decodable {
    let data: [Artist]
    
    enum CodingKeys: String, CodingKey {
        case data
    }
}

struct Artist: Decodable {
    let id: Int
    let name: String
    let picture: String
    let picture_big: String
    let tracklist: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case picture
        case tracklist
        case picture_big
    }
}
