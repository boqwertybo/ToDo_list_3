//
//  MainTableViewController.swift
//  ToDoLit_2
//
//  Created by Bogdan on 05.09.2020.
//  Copyright © 2020 Bogdan. All rights reserved.
//

import UIKit
import RealmSwift

extension MainTableViewController: CreateTaskViewControllerDelegate{
    
    func filltheCell(info: String) {
        let task = ModelTasks()
        task.task = info
        
        do{
            try realm.write {
               realm.add(task)
                print("task1 ID: \(task.taskID)")
            }
        } catch{
            print("Error Realm")
        }
        
        let indexPathNewRow = IndexPath(row: anyArray.count - 1, section: 0)
        tableView.insertRows(at: [indexPathNewRow], with: .automatic)
    }
    
}

final class MainTableViewController: UITableViewController {
    
    var textTask : String = ""
    var anyArray : Results<ModelTasks>!
    
       lazy var realm : Realm = {// не ебу почему лейзи и как избавиться от форса
         return try! Realm() 
     }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        anyArray = realm.objects(ModelTasks.self)
    }
    
    func changeCheckmark(index: Int) {
        do{
            try realm.write {
               self.anyArray[index].completed = !anyArray[index].completed
               realm.add(anyArray[index], update: .all)
            }
        } catch{
            print("Error Realm")
        }
    }
    
    @IBAction func addTaskButton(_ sender: Any) {
        guard let createTaskViewController = self.storyboard?.instantiateViewController(withIdentifier: "noteVC")
            as? CreateTaskViewController else {
            return
        }
        self.present(createTaskViewController, animated:true, completion:nil)
        createTaskViewController.delegate = self
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell : MainTableViewCell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as? MainTableViewCell else {
            return UITableViewCell()
        }
        
        cell.changeState = { [weak self] in
            self?.changeCheckmark(index: indexPath.row)
        }
        
        let item = anyArray[indexPath.row]
        cell.textLabel?.text = item.task
        
        if item.completed == false {
            cell.imgSealCheckmark.isHidden = false
            cell.imgFillCheckmark.isHidden = true
        }
        else {
            cell.imgSealCheckmark.isHidden = true
            cell.imgFillCheckmark.isHidden = false
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return anyArray.count
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            do {
                try self.realm.write {
                self.realm.delete(anyArray[indexPath.row])
                }
            } catch {
                print("Error Realm")
            }
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
