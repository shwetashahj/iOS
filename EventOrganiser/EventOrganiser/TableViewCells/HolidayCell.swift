//
//  HolidayCell.swift
//  EventOrganiser
//
//  Created by shweta shah on 12/10/18.
//  Copyright © 2018 shweta shah. All rights reserved.
//

import UIKit

class HolidayCell: UITableViewCell {
    
    @IBOutlet weak var holidayNameLabel: UILabel!
    
    static var identifier : String {
        return String(describing: self)
    }
    
    var eventsModel : EventModel = EventModel() {
        didSet {
            self.configureCell()
        }
    }
    
    func configureCell() {
        self.holidayNameLabel.text = self.eventsModel.title
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
