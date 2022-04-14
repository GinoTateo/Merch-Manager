//
//  routeInfor.swift
//  Merch Manager
//
//  Created by Gino Tateo on 4/11/22.
//

import Foundation
import SwiftUI

struct Location: Identifiable, Codable, Equatable {
    let id: UUID
    let number: String
    let latitude: Double
    let longitude: Double
}
