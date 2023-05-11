//
//  AppDelegate.swift
//  LuluLemonTest
//
//  Created by Derefaa Cline on 5/10/23.
//

import Foundation

class ListModel {
    var itemArray = [Item]()
    // function to fetch data from the database
    func getDatabaseInfo(num: Int){
        let handler = DatabaseManager.shared
        handler.fetchData { (arr:[Item], error: Error?) in
            if error == nil{
                if num == 0{
                    self.itemArray  = arr.sorted(by: { (g1, g2) -> Bool in
                        g1.name! < g2.name!
                    })
                }else{
                    self.itemArray  = arr.sorted(by: { (g1, g2) -> Bool in
                        g1.time > g2.time
                    })
                }
            }
        }
    }
    
    // get the item count
    func getCount() -> Int{
        return itemArray.count
    }
    
    // get the item name to be shown
    func getName(index: Int)-> String?{
        return itemArray[index].name
    }
}
