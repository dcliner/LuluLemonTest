//
//  AppDelegate.swift
//  LuluLemonTest
//
//  Created by Derefaa Cline on 5/10/23.
//

import Foundation

import UIKit
// item data model formed
class itemModel {
    var id = UUID()
    var name:String?
    var timeStamp:Double?
    init (name:String?,timeStamp:Double?){
        self.name = name
        self.timeStamp = timeStamp
    }
    init(){}
}
