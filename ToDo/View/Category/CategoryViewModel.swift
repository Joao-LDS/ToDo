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
    let db = DataBaseStack.shared
    
    func saveNewCategory(with name: String) {
        let category = Category()
        category.name = name
        db.save(category)
    }
    
    func loadCategories() {
        self.categories = db.loadCategories()
    }
}
