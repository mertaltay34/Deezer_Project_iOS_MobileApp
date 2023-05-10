//
//  Category.swift
//  Deezer_Project
//
//  Created by Mert Altay on 10.05.2023.
//

import Foundation
struct Data: Decodable {
    let data: [Category]
    
    enum CodingKeys: String, CodingKey {
        case data
    }
}

struct Category: Decodable {
    let id: Int
    let name: String
    let picture: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case picture
    }
}
