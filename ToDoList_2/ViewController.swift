//
//  ViewController.swift
//  ToDoList_2
//
//  Created by Bogdan on 05.09.2020.
//  Copyright © 2020 Bogdan. All rights reserved.
//

import UIKit

protocol CreateTaskViewControllerDelegate: AnyObject {
    func filltheCell(info: String)
}

final class CreateTaskViewController: UIViewController {

    weak var delegate : CreateTaskViewControllerDelegate?
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func doneButton(_ sender: Any) {
        guard let textTask = textField.text else{
            return
        }
        delegate?.filltheCell(info: textTask)
        self.dismiss(animated: true, completion: nil)
    }
    
    
}

