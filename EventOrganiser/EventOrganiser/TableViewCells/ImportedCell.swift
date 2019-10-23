//
//  ImportedCell.swift
//  EventOrganiser
//
//  Created by shweta shah on 12/10/18.
//  Copyright © 2018 shweta shah. All rights reserved.
//

import UIKit

class ImportedCell: UITableViewCell {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var importedMeetingNameLabel: UILabel!
    
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
            self.timeLabel.text = Utilities.getFormattedDateString(expected: UIConstants.TimeFormats.eventTime, dateObject: eventDate)
        }
        self.importedMeetingNameLabel.text = self.eventsModel.title
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
