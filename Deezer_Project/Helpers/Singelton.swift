//
//  Singelton.swift
//  Deezer_Project
//
//  Created by Mert Altay on 12.05.2023.
//

import Foundation

class Singleton {
    static let shared = Singleton()
    var genreCategoryId: Int?
    var artistId: Int?
    var artistTrackList: String?
    var albumId: Int?
    var artistName: String?
}
