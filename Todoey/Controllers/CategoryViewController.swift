//
//  CategoryViewController.swift
//  Todoey
//
//  Created by  Mr.Ki on 07.01.2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import UIKit
import RealmSwift
import SwipeCellKit



class CategoryViewController: UITableViewController {

    
    
    
    let realm = try! Realm()
    
    var categories: Results<Category>?

  //  let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
 

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategory()
        
        tableView.rowHeight = 80.0


    }
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! SwipeTableViewCell
        cell.delegate = self
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No categories added yet"
            
           
   //     let itemCategory = categoryArray[indexPath.row]
        
     
    
        
        return cell
    }
    
    //MARK: - TableView Delegate Method
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)

        tableView.deselectRow(at: indexPath, animated: true)
  
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
        
        
    }
    
    //MARK: - Add New Categories
    
  
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        
        let alert = UIAlertController(title: "Add new category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add category", style: .default) { (action) in
            
         
            
            

            let newCategory = Category()
            
            
            newCategory.name = textField.text!
            
            
        //    self.categories.append(newCategory)
            
    
            
            self.save(category: newCategory)
            
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new category"
            textField = alertTextField
           
        }
        alert.addAction(action)
    
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
   

    
  
    //MARK: - Data Manipulation Methods
    func save(category: Category)  {
      
        
        do {
            try realm.write {
            realm.add(category)
            }
        } catch {
         print("Error saving context, \(error)")
        }
        
        
        self.tableView.reloadData()
    }
    
    func loadCategory() {

        categories = realm.objects(Category.self)
        
//        do {
//        categoryArray = try context.fetch(request)
//        } catch {
//            print("Error fetching data from context, \(error)")
//        }

        self.tableView.reloadData()
    }
    
    
    
}

extension CategoryViewController: SwipeTableViewCellDelegate {

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }

        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { [self] action, indexPath in
           print("Item deleted")
            
            if let categoryForDeletion = self.categories?[indexPath.row] {
            
            do {
                try self.realm.write {
                    self.realm.delete(categoryForDeletion)
                }
            } catch {
             print("Error delete data, \(error)")
            }
            }
            
       //     tableView.reloadData()
            
         
        }

        // customize the action appearance
        deleteAction.image = UIImage(named: "delete-icon")

        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
     //   options.transitionStyle = .border
        return options
    }
    
}
