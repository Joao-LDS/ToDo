//
//  DataBaseStack.swift
//  ToDo
//
//  Created by João Luis Santos on 11/01/21.
//  Copyright © 2021 João Luis Santos. All rights reserved.
//

import Foundation
import RealmSwift

class DataBaseStack {
    static let shared = DataBaseStack()
    let realm = try! Realm()
    
    func save(_ category: Category) {
        do {
            try realm.write {
               realm.add(category)
            }
        } catch {
            print("Degub: Error saving new Item.")
        }
    }
    
    func saveItem(in category: Category,_ item: Item) {
        do {
            try realm.write({
                category.items.append(item)
            })
        } catch {}
    }
    
    func loadCategories() -> Results<Category> {
        let categories = realm.objects(Category.self)
        return categories
    }
    
}
