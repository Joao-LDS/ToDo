//
//  ItemsViewModel.swift
//  ToDo
//
//  Created by João Luis Santos on 11/01/21.
//  Copyright © 2021 João Luis Santos. All rights reserved.
//

import Foundation
import RealmSwift

class ItemsViewModel {
    
    var items: Results<Item>?
    var category: Category? {
        didSet {
            loadItems()
        }
    }
    let db = DataBaseStack.shared
    
    func saveItem(with title: String) {
        if let category = self.category {
            let item = Item()
            item.title = title
            db.saveItem(in: category, item)
        }
    }
    
    func loadItems() {
        self.items = category?.items.sorted(byKeyPath: "title", ascending: true)
    }
    
    func writeDoneIn(_ item: Item) {
        db.writeDoneIn(item)
    }
}
