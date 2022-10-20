//
//  userInfo.swift
//  Merch Manager
//
//  Created by Gino Tateo on 2/15/22.
//

import Foundation
import SwiftUI

struct UserInfo {
  let userName: String
  let email: String
  let routeNumber: String
  let authenticated: Bool
  let dow: String
    let firstName: String
    let lastName: String
    let postion: String
    var numStores: Int
    let currPlanPos: Int
    var IsRSR: Bool
}

struct DayData {
    let beginDay: Bool
    let startTime: Date
    let currStore: Int16
}

struct ScanList: Identifiable {
    let id = UUID()
    var numItem: Int16
    var arrayItem: [String]
    
}

struct LocationInfo {
    let number: String
    let latitude: Double
    let longitude: Double
}

struct dow {
    var Today: String
    
    private func greeting() -> String{
        let hour = Calendar.current.component(.hour, from: Date())
        
        if hour < 12 {
            return "Good Morning, "
        }
        if hour > 12 && hour < 15{
            return "Good Afternoon, "
        }
        if hour > 15{
            return "Good Evening, "
        }
        else{
            return "Hello, "
        }
    }
    
    private func GetWeekday() -> String{
        let index = Foundation.Calendar.current.component(.weekday, from: Date()) // this returns an Int

        let weekdays = [ // Week days 0-6
            "Sunday",
            "Monday",
            "Tuesday",
            "Wednesday",
            "Thursday",
            "Friday",
            "Saturday"
        ]
        
        return weekdays[index-1] // Returns week day in String
        }

}



