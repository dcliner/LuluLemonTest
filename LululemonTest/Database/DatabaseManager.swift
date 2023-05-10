//
//  AppDelegate.swift
//  LuluLemonTest
//
//  Created by Derefaa Cline on 5/10/23.
//

import Foundation
import UIKit
import CoreData

class DatabaseManager{
    let appdelegate = UIApplication.shared.delegate as! AppDelegate
    static let shared = DatabaseManager()
    private init(){}
    
    func updateElement(itemId:UUID,name:String){
        let item: Item!
        
        let fetchItem = NSFetchRequest<Item>.init(entityName: "Item")
        fetchItem.predicate = NSPredicate(format: "id = %@", itemId  as CVarArg)
        let results = try? appdelegate.getViewContext().fetch(fetchItem)
        if results?.count == 0{
            item = Item(context: appdelegate.getViewContext())
        }else{
            item = results?.first
        }
        
        item.id = itemId
        item.name = name
        appdelegate.saveContext()

        
    }
    // function to insert the item into the database
    func insertItem(name: String, time: Double){
        let item = Item.init(context: appdelegate.getViewContext())
        item.id = UUID()
        item.name = name
        item.time = time
        appdelegate.saveContext()
    }
    
    // fucntion to fetch the data
    func fetchData(completionHandler: @escaping ([Item], Error?)->()){
        var arr = [Item]()
        let fr = NSFetchRequest<Item>.init(entityName: "Item")
        do {
            arr = try appdelegate.getViewContext().fetch(fr)
            completionHandler(arr,nil)
        } catch {
            print(error)
        }
    }
}
