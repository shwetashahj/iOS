//
//  HeaderCell.swift
//  EventOrganiser
//
//  Created by shweta shah on 12/10/18.
//  Copyright © 2018 shweta shah. All rights reserved.
//

import UIKit

class HeaderCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    
    static var identifier : String {
        return String(describing: self)
    }
    
    var eventsModel : EventModel = EventModel() {
        didSet {
            self.configureCell()
        }
    }
    
    func configureCell() {
        
        if let eventDate = self.eventsModel.eventDate {
            self.dateLabel.text = Utilities.getFormattedDateString(expected: UIConstants.TimeFormats.dateHeaderTime, dateObject: eventDate)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
