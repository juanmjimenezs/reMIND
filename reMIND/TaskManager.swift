//
//  TaskManager.swift
//  reMIND
//
//  Created by Juan Manuel Jimenez Sanchez on 29/01/17.
//  Copyright © 2017 Juan Manuel Jimenez Sanchez. All rights reserved.
//

import Foundation

class TaskManager {
    static let sharedInstance = TaskManager()
    var tasks: [[String:String]] = [[String:String]]()
    
    func save() {
        UserDefaults.standard.set(tasks, forKey: "tasks")
    }
    
    func load() {
        if let array = UserDefaults.standard.array(forKey: "tasks") as? [[String:String]] {
            self.tasks = array
        }
    }
}
