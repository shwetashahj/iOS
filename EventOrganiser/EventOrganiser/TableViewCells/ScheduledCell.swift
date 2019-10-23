//
//  ScheduledCell.swift
//  EventOrganiser
//
//  Created by shweta shah on 12/10/18.
//  Copyright © 2018 shweta shah. All rights reserved.
//

import UIKit

class ScheduledCell: UITableViewCell {
    
    @IBOutlet weak var typeIndicatorView: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var eventStatusLabel: UILabel!
    @IBOutlet weak var meetingNameLabel: UILabel!
    @IBOutlet weak var groupNameLabel: UILabel!
    @IBOutlet weak var locationName: UILabel!
    
    static var identifier : String {
        return String(describing: self)
    }
    
    var eventsModel : EventModel = EventModel() {
        didSet {
            self.configureCell()
        }
    }
    
    func configureCell() {
        setData()
        setTheme()
    }
    
    
    func setData() {
        
        if let eventDate = self.eventsModel.eventDate {
            self.timeLabel.text = Utilities.getFormattedDateString(expected: UIConstants.TimeFormats.eventTime, dateObject: eventDate)
        }
        self.meetingNameLabel.text = eventsModel.title
        self.locationName.text = eventsModel.location
        self.groupNameLabel.text = "\(eventsModel.groupName) / \(eventsModel.clientName)"
        
        switch eventsModel.status {
        case .attending:
            self.eventStatusLabel.text = UIConstants.EventStatus.attending
        case .invited:
            self.eventStatusLabel.text = UIConstants.EventStatus.invited
        default:
            self.eventStatusLabel.text = UIConstants.EventStatus.notAttending
        }
    }
    
    
    func setTheme() {
        
        switch self.eventsModel.status {
            
        case .attending:
            self.typeIndicatorView.backgroundColor = UIConstants.UIColors.acceptedStatus
            self.eventStatusLabel.textColor = UIConstants.UIColors.acceptedStatus
            self.timeLabel.textColor = .black
            self.meetingNameLabel.textColor = .black
        case .invited:
            self.typeIndicatorView.backgroundColor = UIConstants.UIColors.invitedStatus
            self.eventStatusLabel.textColor = UIConstants.UIColors.invitedStatus
            self.timeLabel.textColor = .black
            self.meetingNameLabel.textColor = .black
        default:
            self.typeIndicatorView.backgroundColor = .lightGray
            self.eventStatusLabel.textColor =  .lightGray
            self.timeLabel.textColor =  .lightGray
            self.meetingNameLabel.textColor = .lightGray
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
