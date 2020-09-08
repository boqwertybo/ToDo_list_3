//
//  ModelTasks.swift
//  ToDoList_2
//
//  Created by Bogdan on 07.09.2020.
//  Copyright © 2020 Bogdan. All rights reserved.
//

import Foundation
import RealmSwift

public class ModelTasks : Object{
    @objc dynamic var task = ""
    @objc dynamic var taskID = UUID().uuidString
    @objc dynamic var completed = false
    /*{
        
        willSet(newTotalSteps) {
            print("willSet:\(newTotalSteps)" )
        }
        didSet {
                print("didSet:\(oldValue)")
        }
    }*/
    
    
   public override class func primaryKey() -> String? {
     return "taskID"
    }
    
    

    
}
