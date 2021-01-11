//
//  CategoryViewModel.swift
//  ToDo
//
//  Created by João Luis Santos on 11/01/21.
//  Copyright © 2021 João Luis Santos. All rights reserved.
//

import Foundation

class CategoryViewModel {
    
    var items: [Item] = [Item(title: "Café", done: false), Item(title: "Almoço")]
    
    func addItem(with title: String) {
        let item = Item(title: title)
        items.append(item)
    }
}
