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
        let alert = UIAlertController().createAlertWithTextField(with: "Novo Item") { nameItem in
            self.viewModel.saveItem(with: nameItem)
            self.tableView.reloadData()
        }
        present(alert, animated: true)
    }
    @IBAction func trashButtonPressed(_ sender: UIBarButtonItem) {
        let actionSheet = UIAlertController().createActionSheet(with: "", message: "Deseja apagar os items marcados?") {
            if let items = self.viewModel.items {
                for item in items {
                    if item.done == true {
                        self.viewModel.delete(item)
                    }
                }
                self.tableView.reloadData()
            }
        }
        present(actionSheet, animated: true)
    }
    
}

// MARK: - UITableViewDataSource

extension ItemsTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath)
        let item = viewModel.items?[indexPath.row]
        cell.textLabel?.font = UIFont(name: "Avenir", size: 24)
        
        cell.textLabel?.text = item?.title ?? "Não foram adicionadas categorias"
        cell.accessoryType = item?.done == true ? .checkmark : .none
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ItemsTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item = viewModel.items?[indexPath.row] {
            viewModel.writeDoneIn(item)
            tableView.reloadData()
        }
    }
}

// MARK: - UISearchBarDelegate

extension ItemsTableViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.items = viewModel.items?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "title", ascending: true)
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            viewModel.loadItems()
            tableView.reloadData()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}
