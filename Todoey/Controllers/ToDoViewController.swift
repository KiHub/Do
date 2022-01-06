//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreData

class ToDoViewController: UITableViewController {
    
    var itemArray = [Item]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
  //  let defaults = UserDefaults.standard
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(FileManager.default.urls(for: .documentDirectory,
                                       in: .userDomainMask))
        
        
      //  print(dataFilePath)
        
//        let newItem = Item()
//        newItem.title = "Find Nemo"
//        itemArray.append(newItem)
//        
//        let newItem2 = Item()
//        newItem2.title = "Buy Apple"
//        itemArray.append(newItem2)
//        
//        let newItem3 = Item()
//        newItem3.title = "Say Hello"
//        itemArray.append(newItem3)
        
      
        
        loadItems()
        
//        if let items = defaults.array(forKey: "ToDoListArray") as? [Item] {
//            itemArray = items
//        }
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row].title
        let item = itemArray[indexPath.row]
        
        cell.accessoryType = item.done == true ? .checkmark : .none
//
//        if itemArray[indexPath.row].done == true {
//            cell.accessoryType = .checkmark
//        } else {
//            cell.accessoryType = .none
//        }
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
     //   print("Do, \(itemArray[indexPath.row])")
        
     
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
     
        
        
        saveItems()
        
        
        tableView.deselectRow(at: indexPath, animated: true)
        
       
    }
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        
        let alert = UIAlertController(title: "Add new task", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            
          //  let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            
            let newItem = Item(context: self.context)
             
            
            newItem.title = textField.text!
            newItem.done = false
            
            self.itemArray.append(newItem)
            
     //       self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            
            self.saveItems()
            
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new task"
            textField = alertTextField
           
        }
        alert.addAction(action)
    
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func saveItems()  {
      
        
        do {
         //   let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
           try context.save()
        } catch {
         print("Error saving context, \(error)")
        }
        
        
        self.tableView.reloadData()
    }
    
    func loadItems() {
       
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        do {
        itemArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context, \(error)")
        }
    }
    
}

