//
//  UIConstants.swift
//  EventOrganiser
//
//  Created by shweta shah on 12/10/18.
//  Copyright © 2018 shweta shah. All rights reserved.
//

import Foundation
import UIKit


struct UIConstants {
    
    struct EventStatus {
        static let invited = "INVITED"
        static let attending = "ATTENDING"
        static let notAttending = "NOT ATTENDING"
    }
    
    struct TimeFormats {
        static let eventTime : String = "hh:mm"
        static let dateHeaderTime : String = "EEE d MMM yyyy"
    }
    
    struct UIColors {
        static let invitedStatus = UIColor(red: 237.0/255.0, green: 186.0/255.0, blue: 16.0/255.0, alpha: 1)
        static let acceptedStatus = UIColor(red: 102.0/255.0, green: 196.0/255.0, blue: 107.0/255.0, alpha: 1)
        static let notAttendingStatus =  UIColor.lightGray //UIColor(red: 4.0/255.0, green: 158.0/255.0, blue: 255.0/255.0, alpha: 1)
    }
}

