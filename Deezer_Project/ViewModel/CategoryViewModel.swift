//
//  CategoryViewModel.swift
//  Deezer_Project
//
//  Created by Mert Altay on 10.05.2023.
//

import Foundation

protocol ICategoryViewModel {
    func fetchItems()
    
    var categories: [Category] { get set }
    var categoryService: ICategoryService { get }
    
    var categoriesOutPut: CategoriesOutPut? { get }
    
    func setDelegate(output: CategoriesOutPut)
}


class CategoryViewModel: ICategoryViewModel {
    var categoriesOutPut: CategoriesOutPut?
    
    func setDelegate(output: CategoriesOutPut) {
        categoriesOutPut = output
    }
    
    
    var categories: [Category] = []
    
    var categoryService: ICategoryService
    
    init() {
        categoryService = CategoryService()
    }
    func fetchItems() {
        categoryService.fetchAllData { [weak self] response in
            self?.categories = response ?? []
            self?.categoriesOutPut?.saveData(values: self?.categories ?? [])
        }
    }
    
}
