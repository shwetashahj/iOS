//
//  Utilities.swift
//  EventOrganiser
//
//  Created by shweta shah on 12/10/18.
//  Copyright © 2018 shweta shah. All rights reserved.
//

import Foundation



class Utilities {
    
    /// Returns the Formatted dateString with given Date object and output formatType
    static func getFormattedDateString( expected outputFormat : String, dateObject : Date) -> String {
        let newDateFormatter = DateFormatter()
        newDateFormatter.dateFormat = outputFormat
        return newDateFormatter.string(from: dateObject)
    }
    
    static func fetchDataFromLocalJson(name : String)-> NSDictionary? {
        if let path = Bundle.main.path(forResource: name, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                return (jsonResult as! NSDictionary)
            } catch {
                // handle error
            }
        }
        return nil
    }
}
