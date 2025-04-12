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
    
    var eventDate: Date?
    
    func updateLabel() {
        if let eventDate {
            let (timeDiff, isFuture) = DateHelper.timeDifference(targetDate: eventDate)
            
            dateLabel.textColor = isFuture ? .systemGreen :  .systemOrange
            
            dateLabel.text = DateHelper.differenceString(from: timeDiff, for: isFuture)
        }
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
