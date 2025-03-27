//
//  EventCellTableViewCell.swift
//  EventChrono
//
//  Created by Petr Dumanov on 24.03.2025.
//

import UIKit

class EventCell: UITableViewCell {

    @IBOutlet weak var eventLabel: UILabel!
    
    @IBOutlet private weak var dateLabel: UILabel!
    
    func setEventDate(date: Date) {
        let timeDiff = DateHelper.timeDifference(targetDate: date)
        
        dateLabel.textColor = timeDiff.second ?? 0 > 0 ? .systemOrange : .systemGreen //TODO: Refactor
        
        dateLabel.text = DateHelper.differenceString(from: timeDiff)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
