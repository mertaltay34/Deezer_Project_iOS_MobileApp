//
//  CategoryService.swift
//  Deezer_Project
//
//  Created by Mert Altay on 10.05.2023.
//

import Foundation
import Alamofire

let mainUrl = "https://api.deezer.com/genre"

protocol ICategoryService {
    func fetchAllData(response: @escaping ([Category]?) -> Void)
}

struct CategoryService: ICategoryService {
    func fetchAllData(response: @escaping ([Category]?) -> Void) {
        AF.request(mainUrl).responseDecodable(of: CategoryData.self) { model in
            guard let results = model.value else {
                response(nil)
                return
            }
            response(results.data)
            
        }
    }
    
    
}
