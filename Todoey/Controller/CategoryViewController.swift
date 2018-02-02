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
    let categoryArray = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // Mark: -- TableView Data Source Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        let category = categoryArray[indexPath.row]
        
        cell.textLabel?.text = category.name
        
        cell.accessoryType = category.done ? .checkmark : .none
        
        return cell
    
    }
    // Mark: -- TableView Delegate Methods
    
    // Mark: -- Data Manipultation Methods
    func saveCategory() {
        
    }
    
    func loadCategory() {
        
    }
    
    // Mark: -- Add Button Method
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
    }
    
}
