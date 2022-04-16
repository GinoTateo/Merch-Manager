//
//  routeInfor.swift
//  Merch Manager
//
//  Created by Gino Tateo on 4/11/22.
//

import Foundation
import SwiftUI
import FirebaseFirestoreSwift


struct StoreData: Identifiable {
    let id: String = UUID().uuidString
    let StoreName: String
    let StoreNumber: String
    let Region: String
    let location: Location
}


struct Location: Identifiable, Codable, Equatable {
    let id: UUID
    let number: String
    let latitude: Double
    let longitude: Double
}


