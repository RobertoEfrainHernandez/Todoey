//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Roberto Hernandez on 2/2/18.
//  Copyright © 2018 Roberto Efrain Hernandez. All rights reserved.
//

import UIKit
import RealmSwift


class CategoryViewController: SwipeTableViewController {
    
    // Mark: Properties
    let realm = try! Realm()
    var categories : Results<Category>?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategory()
        tableView.rowHeight = 80.0
    }
    
    // Mark: -- TableView Data Source Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        cell.textLabel?.text = categories?[indexPath.row].name ?? "Now Categories added yet."
        
        return cell
    }
    // Mark: -- TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    
    // Mark: -- Data Manipultation Methods
    func save(category: Category) {
        do {
            try realm.write {
                realm.add(category)
            }
        }
        catch {
            print("Error saving context \(error)")
        }
        tableView.reloadData()
    }
    
    //Mark: Load Category
    func loadCategory() {
        
        categories = realm.objects(Category.self)
        
        tableView.reloadData()
    }
    
    // Mark: -- Delete Data from Swipe
    override func updateModel(at indexPath: IndexPath) {
        if let categoriesForDeletion = self.categories?[indexPath.row] {
            do {
                try self.realm.write {
                self.realm.delete(categoriesForDeletion)
                }
                } catch {
                    print("Error Deleting category \(error)")
                }
        }
    }
    
    // Mark: -- Add Button Method
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add Your New Todoey Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Categroy", style: .default) { (action) in
            /* What happens when User clicks add new item */
            let newCategory = Category()
            
            newCategory.name = textField.text!
            
            self.save(category: newCategory)
        }
        
        alert.addTextField { (field) in
            field.placeholder = "Create New Category"
            textField = field
        }
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
}


