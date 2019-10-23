//
//  EventsViewController.swift
//  EventOrganiser
//
//  Created by shweta shah on 10/10/18.
//  Copyright © 2018 shweta shah. All rights reserved.
//

import UIKit

class EventsViewController: UIViewController {
    
    @IBOutlet weak var eventTableView: UITableView!
    let data = EventDataService().fetchEventData();
    
    var eventSectionModel : [EventSectionModel] = [] {
        didSet {
            self.eventTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        fetchEventsData()
    }
    
    
    func setupTableView() {
        self.eventTableView.delegate = self
        self.eventTableView.dataSource = self
    }
    
    
    func fetchEventsData() {
        guard let sectionModel = EventDataService().fetchEventData() else {
            print("No Data present")
            return
        }
        self.eventSectionModel = sectionModel
    }
}


//MARK:- TableView DataSource & Delegates
extension EventsViewController : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch self.eventSectionModel[indexPath.section].eventModelArray[indexPath.row].eventType {
            
        case .scheduled :
            return getScheduledCell(indexPath: indexPath)
        case .imported:
            return getImportedCell(indexPath: indexPath)
        default:
            return getHolidayCell(indexPath: indexPath)
        }
    }
    
    
    func getScheduledCell( indexPath : IndexPath) -> ScheduledCell {
        let cell = self.eventTableView.dequeueReusableCell(withIdentifier: ScheduledCell.identifier, for: indexPath) as! ScheduledCell
        cell.eventsModel = self.eventSectionModel[indexPath.section].eventModelArray[indexPath.row]
        return cell
    }
    
    
    func getHolidayCell( indexPath : IndexPath) -> HolidayCell {
        let cell = self.eventTableView.dequeueReusableCell(withIdentifier: HolidayCell.identifier, for: indexPath) as! HolidayCell
        cell.eventsModel = self.eventSectionModel[indexPath.section].eventModelArray[indexPath.row]
        return cell
    }
    
    
    func getImportedCell( indexPath : IndexPath) -> ImportedCell {
        let cell = self.eventTableView.dequeueReusableCell(withIdentifier: ImportedCell.identifier, for: indexPath) as! ImportedCell
        cell.eventsModel = self.eventSectionModel[indexPath.section].eventModelArray[indexPath.row]
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventSectionModel[section].eventModelArray.count
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return eventSectionModel.count
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableCell(withIdentifier: "HeaderCell") as! HeaderCell
        if let eventDate = self.eventSectionModel[section].sectionDate {
            headerView.dateLabel.text = Utilities.getFormattedDateString(expected: UIConstants.TimeFormats.dateHeaderTime, dateObject: eventDate )
        }
        return headerView.contentView
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch self.eventSectionModel[indexPath.section].eventModelArray[indexPath.row].eventType {
        case .scheduled :
            return 125
        case .imported:
            return 75
        default:
            return 44
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
   
}
