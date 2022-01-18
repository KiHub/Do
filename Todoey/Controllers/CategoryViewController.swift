//
//  CategoryViewController.swift
//  Todoey
//
//  Created by  Mr.Ki on 07.01.2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework



class CategoryViewController: SwipeViewController {

    
    
    
    let realm = try! Realm()
    
    var categories: Results<Category>?

  //  let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
 

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategory()
        
        tableView.rowHeight = 80.0
        
        tableView.separatorStyle = .none


        
//        if #available(iOS 13.0, *) {
//            let navBarAppearance = UINavigationBarAppearance()
//            navBarAppearance.configureWithOpaqueBackground()
//            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
//            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
//            navBarAppearance.backgroundColor = #colorLiteral(red: 0.28762573, green: 0.3948598504, blue: 0.4191849828, alpha: 1)
//            UINavigationBar.standardAppearance = navBarAppearance
//            UINavigationBar.scrollEdgeAppearance = navBarAppearance
//            UINavigationBarAppearance.scr
//        }
      //  UINavigationBar

    }
    override func viewWillAppear(_ animated: Bool) {
        let app = UINavigationBarAppearance()
        app.backgroundColor = #colorLiteral(red: 0.28762573, green: 0.3948598504, blue: 0.4191849828, alpha: 1)
        
        self.navigationController?.navigationBar.scrollEdgeAppearance = app
        navigationController?.navigationBar.standardAppearance = app
        
    }
    
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        

        cell.textLabel?.text = categories?[indexPath.row].name ??  "No categories added yet"
        
     //   guard let categoryColour = UIColor(hexString: categories?[indexPath.row].colour
      //        else { fatalError() }
            
        cell.backgroundColor = UIColor(hexString: categories?[indexPath.row].colour ?? "#e8afa8")
      //  cell.layer.cornerRadius = 20
      //  cell.layer.masksToBounds = true
    
     //   cell.textLabel?.textColor = ContrastColorOf(backgroundColor: categories?[indexPath.row].colour, returnFlat: true)
    //    cell.backgroundColor = UIColor(hexString: (categories?[indexPath.row].color) ?? "#e8afa8")
   //     UIColor.hexValue(categories?[indexPath.row].color) ?? UIColor.red
     //   UIColor.hexValue(<#T##self: UIColor##UIColor#>)
        
//        let categoruColour =  UIColor(hexString: selectedCategory?.colour ?? "#f3f6f4")
//        if let colour = categoruColour.darken(byPercentage: CGFloat(indexPath.row) / CGFloat(todoItems!.count) ) {
//
//    cell.backgroundColor = colour //?? "#e8afa8"
//            cell.textLabel?.textColor = ContrastColorOf(backgroundColor: colour, returnFlat: true)
//
        
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
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
        
            
         //   let hex = UIColor.randomFlat()?.hexValue()
           

            let newCategory = Category()
            
            
            newCategory.name = textField.text!
         //   newCategory.colour = UIColor.randomFlat().hexValue()
            
            
            newCategory.colour = UIColor(randomFlatColorOf:.light)?.hexValue() ?? "#e8afa8"
            
            newCategory.dateCreatedCategory = Date()
            
            
        //    self.categories.append(newCategory)
            
    
            
            self.save(category: newCategory)
            
            
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: {
            action in
                
        })
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new category"
            textField = alertTextField
           
        }
        alert.addAction(action)
        
        alert.addAction(cancel)
    
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

    //    categories = realm.objects(Category.self)
        categories = realm.objects(Category.self).sorted(byKeyPath: "dateCreatedCategory", ascending: false)
      //  categories = selectedCategory?.items.sorted(byKeyPath: "dateCreated", ascending: false)
        
//        do {
//        categoryArray = try context.fetch(request)
//        } catch {
//            print("Error fetching data from context, \(error)")
//        }

        self.tableView.reloadData()
    }
    
    //MARK: - Delete dat afrom swipe
    override func updateModel(at indexPath: IndexPath) {
        
        
                    if let categoryForDeletion = self.categories?[indexPath.row] {
        
                    do {
                        try self.realm.write {
                            self.realm.delete(categoryForDeletion)
                        }
                    } catch {
                     print("Error delete data, \(error)")
                    }
                    }
        
    }
    
}

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
