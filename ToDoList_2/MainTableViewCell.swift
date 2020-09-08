//
//  MainTableViewCell.swift
//  ToDoList_2
//
//  Created by Bogdan on 05.09.2020.
//  Copyright © 2020 Bogdan. All rights reserved.
//

import UIKit

extension UIResponder {
    /**
     * Returns the next responder in the responder chain cast to the given type, or
     * if nil, recurses the chain until the next responder is nil or castable.
     */
    func next<U: UIResponder>(of type: U.Type = U.self) -> U? {
        return self.next.flatMap({ $0 as? U ?? $0.next() })
    }
}

extension UITableViewCell {
    var tableView: UITableView? {
        return self.next(of: UITableView.self)
    }

    var indexPath: IndexPath? {
        return self.tableView?.indexPath(for: self)
    }
}

protocol MainTableViewCellDelegate {
    func changeCheckmark(info: Bool, index: Int?)
}

class MainTableViewCell: UITableViewCell {

    
    
    @IBAction func actionSealCheckmarkButton(_ sender: Any) {
        print("pressed Seal Button")
        sealChecmarkButton.isHidden = true
        fillChechmarkButton.isHidden = false
        delegate?.changeCheckmark(info: true, index: indexPath?.row)
        
    }
    
    @IBAction func actionFillCheckmarkButton(_ sender: Any) {
        print("pressed Fill Button")
        delegate?.changeCheckmark(info: false, index: indexPath?.row)
        fillChechmarkButton.isHidden = true
        sealChecmarkButton.isHidden = false
        
    }
    
    var delegate : MainTableViewCellDelegate?
    @IBOutlet weak var sealChecmarkButton: UIButton!
    @IBOutlet weak var fillChechmarkButton: UIButton!
    @IBOutlet weak var nameTaskLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        fillChechmarkButton.isHidden = true
        sealChecmarkButton.isHidden = false
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
