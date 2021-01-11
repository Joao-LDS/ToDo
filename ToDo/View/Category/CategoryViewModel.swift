//
//  CategoryViewModel.swift
//  ToDo
//
//  Created by João Luis Santos on 11/01/21.
//  Copyright © 2021 João Luis Santos. All rights reserved.
//

import Foundation
import RealmSwift

class CategoryViewModel {
    
    var categories: Results<Category>?
    let dataBaseStack = DataBaseStack.shared
    
    func saveNewCategory(with name: String) {
        let category = Category()
        category.name = name
        dataBaseStack.save(category)
    }
    
    func loadCategories() {
        categories = dataBaseStack.loadCategories()
    }
}
