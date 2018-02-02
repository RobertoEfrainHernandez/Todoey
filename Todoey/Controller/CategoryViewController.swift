//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Roberto Hernandez on 2/2/18.
//  Copyright © 2018 Roberto Efrain Hernandez. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    // Mark: Properties
    var categoryArray = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategory()
    }
    
    // Mark: -- TableView Data Source Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        let category = categoryArray[indexPath.row]
        
        cell.textLabel?.text = category.name
        
        return cell
    }
    // Mark: -- TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryArray[indexPath.row]
        }
    }
    
    // Mark: -- Data Manipultation Methods
    func saveCategory() {
        do {
            try context.save()
        }
        catch {
            print("Error saving context \(error)")
        }
        tableView.reloadData()
    }
    
    func loadCategory(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
        do {
            categoryArray = try context.fetch(request)
        }
        catch {
            print("Error fetching Data from context \(error)")
        }
    }
    
    // Mark: -- Add Button Method
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add Your New Todoey Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Categroy", style: .default) { (action) in
            /* What happens when User clicks add new item */
            let newCategory = Category(context: self.context)
            
            newCategory.name = textField.text!
            
            
            self.categoryArray.append(newCategory)
            
            self.saveCategory()
        }
        
        alert.addTextField { (field) in
            field.placeholder = "Create New Category"
            textField = field
        }
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
}
