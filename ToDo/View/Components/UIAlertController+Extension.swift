//
//  UIAlertController+Extension.swift
//  ToDo
//
//  Created by João Luis Santos on 12/01/21.
//  Copyright © 2021 João Luis Santos. All rights reserved.
//

import UIKit

extension UIAlertController {

    func createAlertWithTextField(with title: String, handle: @escaping (_ title: String) -> Void) -> UIAlertController {
        let alert = UIAlertController(title: title, message: "", preferredStyle: .alert)
        var textField = UITextField()
        
        alert.addTextField { alertTextField in
            textField = alertTextField
        }
        
        let addAction = UIAlertAction(title: "Adicionar", style: .default) { action in
            if let name = textField.text, name != "" {
                handle(name)
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel)
        
        alert.addAction(addAction)
        alert.addAction(cancelAction)
        
        return alert
    }
    
    func createActionSheet(with title: String, message: String, handle: @escaping () -> Void) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        let deleteAction = UIAlertAction(title: "Apagar", style: .default) { action in
            handle()
        }
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel)
        
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        
        return alert
    }
    
}
