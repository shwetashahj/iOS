//
//  EventDataService.swift
//  EventOrganiser
//
//  Created by shweta shah on 10/10/18.
//  Copyright © 2018 shweta shah. All rights reserved.
//

import Foundation

class EventDataService{

    func fetchEventData() -> [EventSectionModel]? {
        
        var eventsModel : [EventModel] = []
        guard let eventDict = Utilities.fetchDataFromLocalJson(name: "Events" ) else {
            print("JSON not found")
            return nil
        }
        guard let dataArray = eventDict["data"] as? [[String : Any]] else {
            return nil
        }
        for events in dataArray {
            let event = EventModel(params: events)
            eventsModel.append(event)
        }        
        let sortedEventsModel = getSortedEventsModelArray(eventModelArray: eventsModel)
        let sectionModel = getEventSectionModel(eventModelArray: sortedEventsModel)
        return sectionModel
    }
}



//MARK:- Utils
extension EventDataService{
    
    //Sort the events model to order the dates
    func getSortedEventsModelArray( eventModelArray : [EventModel]) -> [EventModel] {
        
        return eventModelArray.sorted { (model1, model2) -> Bool in
            guard let date1 = model1.eventDate, let date2 = model2.eventDate else {
                return false
            }
            return date1 < date2
        }
    }
    
    //Fetch the Unique dates from the events model
    func getUniqueEventDates( eventArray : [EventModel]) -> [Date] {
        var uniqueDateArray : [Date] = []
        var uniqueDate : Date?
        
        for events in eventArray {
            if let date = events.sectionDate {
                if date != uniqueDate {
                    uniqueDate = date
                    uniqueDateArray.append(date)
                }
            }
        }
        return uniqueDateArray
    }
    
    
    //Get Events Section Model populated with Events sorted by dates
    func getEventSectionModel( eventModelArray : [EventModel]) -> [EventSectionModel] {
                
        var sectionModelArray : [EventSectionModel] = []
        let uniqueSectionDateArray = getUniqueEventDates(eventArray: eventModelArray)
        
        
        for uniqueDate in uniqueSectionDateArray {
            
            var sectionModel : EventSectionModel = EventSectionModel()
            sectionModel.sectionDate = uniqueDate
            
            for event in eventModelArray {
                guard let eventDate = event.sectionDate else {
                    continue
                }
                if eventDate == uniqueDate {
                    sectionModel.eventModelArray.append(event)
                }
            }
            sectionModelArray.append(sectionModel)
        }
        return sectionModelArray
    }
}
