//
//  MainTableViewCell.swift
//  ToDoList_2
//
//  Created by Bogdan on 05.09.2020.
//  Copyright © 2020 Bogdan. All rights reserved.
//

import UIKit

final class MainTableViewCell: UITableViewCell {
    
    var changeState: (() -> Void)?
    @IBOutlet weak var imgFillCheckmark: UIImageView!
    @IBOutlet weak var imgSealCheckmark: UIImageView!
    
    @IBAction func actionCheckmarkButton(_ sender: Any) {
        imgFillCheckmark.isHidden = !imgFillCheckmark.isHidden
        imgSealCheckmark.isHidden = !imgSealCheckmark.isHidden
        self.changeState?()
    }
}
