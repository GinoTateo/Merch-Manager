//
//  userInfo.swift
//  Merch Manager
//
//  Created by Gino Tateo on 2/15/22.
//

import Foundation
import SwiftUI
import GameController

struct UserInfo {
  let userName: String
  let email: String
  let routeNumber: String
  let authenticated: Bool
    let dow: String
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



