//
//  Category.swift
//  Todoey
//
//  Created by  Mr.Ki on 10.01.2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
   @objc dynamic var name: String = ""
    @objc dynamic var colour: String = ""
    @objc dynamic var dateCreatedCategory: Date?
        //= "#d3ffce"
    let items = List<Item>()
    
    
}
