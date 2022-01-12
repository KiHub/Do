//
//  SwipeViewController.swift
//  Todoey
//
//  Created by  Mr.Ki on 12.01.2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import UIKit

import SwipeCellKit

class SwipeViewController: UITableViewController, SwipeTableViewCellDelegate {
    
    var cell: UITableViewCell?

    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
               let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SwipeTableViewCell
                
        cell.delegate = self
                
                return cell
    }
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }

        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { [self] action, indexPath in
           print("Delete cell")
            
            self.updateModel(at: indexPath)
            
            
//            if let categoryForDeletion = self.categories?[indexPath.row] {
//
//            do {
//                try self.realm.write {
//                    self.realm.delete(categoryForDeletion)
//                }
//            } catch {
//             print("Error delete data, \(error)")
//            }
//            }
//
     
            
         
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
    
    func updateModel(at indexPath: IndexPath) {
        //MARK: - Updade our data model
        
        
        
    }
    
}


