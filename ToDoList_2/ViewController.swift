//
//  ViewController.swift
//  ToDoList_2
//
//  Created by Bogdan on 05.09.2020.
//  Copyright © 2020 Bogdan. All rights reserved.
//

import UIKit

protocol ViewControllerDelegate {
    func filltheCell(info: String)
}

class ViewController: UIViewController {

    
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func doneButton(_ sender: Any) {
        let textTask = textField.text
        delegate?.filltheCell(info: textTask!)
        self.dismiss(animated: true, completion: nil)
    }
    
    var delegate : ViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    


}

