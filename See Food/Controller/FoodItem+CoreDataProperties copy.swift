//
//  FoodItem+CoreDataProperties.swift
//  
//
//  Created by Thejaswi Kampalli on 5/30/20.
//
//

import Foundation
import CoreData


extension FoodItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FoodItem> {
        return NSFetchRequest<FoodItem>(entityName: "FoodItem")
    }

    @NSManaged public var img: Data?
    @NSManaged public var title: String?
    @NSManaged public var foodDescription: String?

}
