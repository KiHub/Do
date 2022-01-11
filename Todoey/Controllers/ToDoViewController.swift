//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import RealmSwift

class ToDoViewController: UITableViewController {
    
    var todoItems: Results<Item>?
    let realm = try! Realm()
    
    
    var selectedCategory : Category? {
        didSet {
           loadItems()
        }
    }
    
    
  
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(FileManager.default.urls(for: .documentDirectory,
                                       in: .userDomainMask))
    //    searchBar.delegate = self
        
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
        
       
        
      //  loadItems()
        
//        if let items = defaults.array(forKey: "ToDoListArray") as? [Item] {
//            itemArray = items
//        }
        
    }
    
    //MARK: - Tableview Datasource Methods

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        if let item = todoItems?[indexPath.row] {
            cell.textLabel?.text = item.title
            cell.accessoryType = item.done ? .checkmark : .none
        } else {
            cell.textLabel?.text = "No items added"
        }
        
     
//
//        if itemArray[indexPath.row].done == true {
//            cell.accessoryType = .checkmark
//        } else {
//            cell.accessoryType = .none
//        }
        
        return cell
    }
    
    //MARK: - Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if let item = todoItems?[indexPath.row] {
            do {
            try realm.write {
     //           realm.delete(item)
                             item.done = !item.done
            }
            } catch {
                print("Error saving done status, \(error)")
            }
            
            tableView.reloadData()
        
     //   print("Do, \(itemArray[indexPath.row])")
        
     
        //MARK: - Delete data
   //     context.delete(itemArray[indexPath.row])
   //     itemArray.remove(at: indexPath.row)
        
        
//        todoItems[indexPath.row].done = !todoItems[indexPath.row].done
//
//
//
//
//        saveItems()
        
        
        tableView.deselectRow(at: indexPath, animated: true)
        
       
    }
    }
    
    //MARK: - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        
        let alert = UIAlertController(title: "Add new task", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            
          //  let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            if let currentCategory = self.selectedCategory {
                do {
                    try self.realm.write {
                        let newItem = Item()
                        newItem.title = textField.text!
                        newItem.dateCreated = Date()
                            currentCategory.items.append(newItem)
                    }
                } catch {
                 print("Error saving new items, \(error)")
                }
            
            }
         //   newItem.parentCategory = self.selectedCategory
          //  self.itemArray.append(newItem)
            
            
     //       self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            
            
           
            
            
         self.tableView.reloadData()
//
//            self.saveItems()
            
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new task"
            textField = alertTextField
           
        }
        alert.addAction(action)
    
        self.present(alert, animated: true, completion: nil)
        
    }
    
    //MARK: - Model Manipulation Methods
    
//    func saveItems()  {
//
//
//        do {
//         //   let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//           try context.save()
//        } catch {
//         print("Error saving context, \(error)")
//        }
//
//
//        self.tableView.reloadData()
//    }
//
    func loadItems() {

        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)

        tableView.reloadData()
    }
//
    
}
//MARK: - Search bar methods

extension ToDoViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        
        tableView.reloadData()
        
//        let request : NSFetchRequest<Item> = Item.fetchRequest()
//
//        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
//
//
//
//        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
//
//        request.sortDescriptors = [sortDescriptor]
//
//        loadItems(with: request, predicate: predicate)



    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {


            loadItems()
            
                     DispatchQueue.main.async {
                         searchBar.resignFirstResponder()
                     }

        }
    }

}

