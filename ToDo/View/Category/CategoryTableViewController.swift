//
//  CategoryTableViewController.swift
//  ToDo
//
//  Created by João Luis Santos on 11/01/21.
//  Copyright © 2021 João Luis Santos. All rights reserved.
//

import UIKit

class CategoryTableViewController: UITableViewController {
    
    var viewModel: CategoryViewModel!
    
    init(viewModel: CategoryViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.viewModel = CategoryViewModel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.loadCategories()
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController().createAlertWithTextField(with: "Nova Categoria") { titleCategory in
            self.viewModel.saveNewCategory(with: titleCategory)
            self.tableView.reloadData()
        }
        present(alert, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! ItemsTableViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destination.viewModel.category = viewModel.categories?[indexPath.row]
        }
    }
    

}

// MARK: - UITableViewDataSource

extension CategoryTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        let category = viewModel.categories?[indexPath.row]
        cell.textLabel?.font = UIFont(name: "Avenir", size: 24)
        cell.textLabel?.text = category?.name ?? "Não foram adicionadas categorias"
        return cell
    }
}

// MARK: - UITableViewDelegate

extension CategoryTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItemsView", sender: self)
    }
}
