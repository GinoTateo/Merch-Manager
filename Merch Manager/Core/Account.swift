//
//  Account.swift
//  Merch Manager
//
//  Created by Gino Tateo on 11/17/22.
//

import Foundation

struct Accout: Codable, Hashable{
    
    let name:String
    let position:String
    let routeNum: Int
    let region: Int
    
}

struct Merch: Codable, Hashable{
    
    let User:String
    let Store:String
    let OOS: Int
    let case_count: Int
    let date: Date
    var upload: Image {
       Image(Store)
    }
    
}
