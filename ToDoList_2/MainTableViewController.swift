//
//  MainTableViewController.swift
//  ToDoList_2
//
//  Created by Bogdan on 05.09.2020.
//  Copyright © 2020 Bogdan. All rights reserved.
//

import UIKit
import RealmSwift

class MainTableViewController: UITableViewController, ViewControllerDelegate, MainTableViewCellDelegate {
    
    func changeCheckmark(info: Bool, index: Int?) {
        let task1 = ModelTasks()
        task1.task = anyArray[index!].task
        task1.completed = info
        task1.taskID = anyArray[index!].taskID
        print(index!)
        print(task1.taskID)
        print("hello")
        
        try! realm.write {
           realm.add(task1, update: .all)
        }
        
        print(anyArray[index!].completed)
        
        
    }
    
    
    func filltheCell(info: String) {
        textTask = info
        print(textTask)
        print("kek")
        addTextTask()
    }
    

    @IBAction func addTaskButton(_ sender: Any) {
        
        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "noteVC") as! ViewController
        self.present(nextViewController, animated:true, completion:nil)
        nextViewController.delegate = self
    }
    
    let realm = try! Realm()
    var textTask : String = ""
    var anyArray : Results<ModelTasks>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        anyArray = realm.objects(ModelTasks.self)
    }

    

    override func numberOfSections(in tableView: UITableView) -> Int {
       
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if anyArray.count != 0{
            return anyArray.count
        }
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! MainTableViewCell
        cell.delegate = self
        

        let item = anyArray[indexPath.row]
        cell.textLabel?.text = item.task
        
        if item.completed == false{
            cell.sealChecmarkButton.isHidden = false
            cell.fillChechmarkButton.isHidden = true
            
        }
        else{
            cell.sealChecmarkButton.isHidden = true
            cell.fillChechmarkButton.isHidden = false
        }

        return cell
    }
    
    public func addTextTask(){
        let task = ModelTasks()
        task.task = textTask
        task.completed = false
        task.task = textTask
        print(task.taskID)
        
        try! self.realm.write{
            self.realm.add(task)
        }
               //anyArray.append(task)
               let indexPathNewRow = IndexPath(row: anyArray.count - 1, section: 0)
               tableView.insertRows(at: [indexPathNewRow], with: .automatic)
        
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
            try! self.realm.write{
                self.realm.delete(anyArray[indexPath.row])
            }
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    


}
