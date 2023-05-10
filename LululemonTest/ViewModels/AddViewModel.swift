//
//  AppDelegate.swift
//  LuluLemonTest
//
//  Created by Derefaa Cline on 5/10/23.
//
import Foundation
class AddViewModel{
    let databaseManager = DatabaseManager.shared
    //saving the particular item we need
    func saveItem(itemName: String){
        databaseManager.insertItem(name: itemName, time: Date().timeIntervalSince1970)

    }
    func updateItem(item:Item){
        databaseManager.updateElement(itemId: item.id ?? UUID(), name: item.name ?? "")
    }
}
