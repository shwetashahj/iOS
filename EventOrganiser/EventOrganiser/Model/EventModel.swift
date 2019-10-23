//
//  eventModel.swift
//  EventOrganiser
//
//  Created by shweta shah on 10/10/18.
//  Copyright © 2018 shweta shah. All rights reserved.
//

import Foundation

enum ScheduledType {
    case notAttending
    case attending
    case invited
    case none
}

enum EventType {
    case scheduled
    case imported
    case holiday
    case none
}


struct EventModel {
    
    var title : String = ""
    var eventType : EventType = .none
    var status : ScheduledType = .none
    var location : String = ""
    var clientName : String = ""
    var groupName : String = ""
    var epochDate : Int = 0
    var eventDate : Date?
    var sectionDate : Date?
    
    init() {}
    
    init( params : [String : Any]) {
        
        if let title = params["title"] as? String {
            self.title = title
        }
        
        if let location = params["location"] as? String {
            self.location = location
        }
        
        if let groupName = params["groupName"] as? String {
            self.groupName = groupName
        }
        
        if let clientName = params["clientName"] as? String {
            self.clientName = clientName
        }
        
        if let status = params["status"] as? Int {
            self.status = getStatusType(status: status)
        }
        
        if let type = params["type"] as? String {
            self.eventType = getEventType(type: type)
        }
        
        if let epochDate = params["datetime"] as? Int {
            self.epochDate = epochDate
            self.eventDate = Date(timeIntervalSince1970: Double(epochDate)/1000)
            if let eventDate = self.eventDate {
                self.sectionDate = self.getSectionDate(eventDate: eventDate)
            }
        }
    }
}


extension EventModel {
    
    func getStatusType(status : Int) -> ScheduledType {
        switch status {
        case 0:
            return .notAttending
        case 1:
            return .attending
        case 2:
            return .invited
        default:
            return .none
        }
    }
    
    
    func getEventType(type : String) -> EventType {
        
        switch type.lowercased() {
        case "scheduled":
            return .scheduled
        case "holiday":
            return .holiday
        case "imported":
            return .imported
        default:
            return .none
        }
    }
    
    
    /// Returns the date object by removing the time
    func getSectionDate(eventDate : Date) -> Date? {
        var calendars = Calendar(identifier: .gregorian)
        calendars.timeZone = TimeZone(identifier: "UTC")!
        let components = calendars.dateComponents([.day, .month, .year], from: eventDate)
        return calendars.date(from: components)
        //
        //let pdate = calendars.date(byAdding: Calendar.Component.day, value: 1, to: newdate)
        //
    }
}
