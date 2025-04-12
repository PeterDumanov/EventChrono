//
//  AddEventCell.swift
//  EventChrono
//
//  Created by Petr Dumanov on 12.04.2025.
//

import UIKit

class AddEventCell: UITableViewCell {
    
    @IBOutlet weak var eventDatePicker: UIDatePicker!
    
    @IBOutlet weak var eventNameTextField: UITextField!
    
    @IBOutlet weak var addEventCellLabel: UILabel!
    
    enum AddEventCellType {
        case text
        case date
    }
    
    var cellType: AddEventCellType? {
        didSet {
            switch cellType {
            case .text:
                addEventCellLabel.text = "Event name"
                eventNameTextField.isHidden = false
                eventDatePicker.isHidden = true
            case .date:
                addEventCellLabel.text = "Event date"
                eventNameTextField.isHidden = true
                eventDatePicker.isHidden = false
            case .none:
                break
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        eventNameTextField.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension AddEventCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
