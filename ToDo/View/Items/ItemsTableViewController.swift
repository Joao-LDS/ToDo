//
//  ItemsTableViewController.swift
//  ToDo
//
//  Created by João Luis Santos on 11/01/21.
//  Copyright © 2021 João Luis Santos. All rights reserved.
//

import UIKit

class ItemsTableViewController: UITableViewController {
    
    var viewModel: ItemsViewModel!
    
    init(viewModel: ItemsViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.viewModel = ItemsViewModel()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Novo Item", message: "", preferredStyle: .alert)
        var textField = UITextField()
        
        alert.addTextField { alertTextField in
            textField = alertTextField
        }
        
        let addAction = UIAlertAction(title: "Adicionar", style: .default) { action in
            if let name = textField.text, name != "" {
                self.viewModel.saveItem(with: name)
                self.tableView.reloadData()
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel)
        
        alert.addAction(addAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
}

// MARK: - UITableViewDataSource

extension ItemsTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath)
        let item = viewModel.category?.items[indexPath.row]
        cell.textLabel?.font = UIFont(name: "Avenir", size: 24)
        cell.textLabel?.text = item?.title ?? "Não foram adicionadas categorias"
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ItemsTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.reloadData()
    }
}

// MARK: - UISearchBarDelegate

extension CategoryTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}
