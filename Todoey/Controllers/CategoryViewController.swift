//
//  CategoryViewController.swift
//  Todoey
//
//  Created by  Mr.Ki on 07.01.2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import UIKit
import CoreData



class CategoryViewController: UITableViewController {
    
    var categoryArray = [Category]()

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
 

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategory()


    }
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = categoryArray[indexPath.row].name
   //     let itemCategory = categoryArray[indexPath.row]
        
     

        
        return cell
    }
    
    //MARK: - TableView Delegate Method
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: true)
  
    }
    
    
    
    //MARK: - Add New Categories
    
  
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        
        let alert = UIAlertController(title: "Add new category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add category", style: .default) { (action) in
            
         
            
            

            let newCategory = Category(context: self.context)
            
            
            newCategory.name = textField.text!
            
            
            self.categoryArray.append(newCategory)
            
    
            
            self.saveCategory()
            
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new category"
            textField = alertTextField
           
        }
        alert.addAction(action)
    
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
   

    
  
    //MARK: - Data Manipulation Methods
    func saveCategory()  {
      
        
        do {
        
           try context.save()
        } catch {
         print("Error saving context, \(error)")
        }
        
        
        self.tableView.reloadData()
    }
    
    func loadCategory(with request: NSFetchRequest<Category> =  Category.fetchRequest()) {
       
  
        do {
        categoryArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context, \(error)")
        }
        self.tableView.reloadData()
    }
    
    
    
}
