//
//  DateModel.swift
//  Merch Manager
//
//  Created by Gino Tateo on 5/21/22.
//

import Foundation

struct DateModel: Hashable {
    var day: Int = 0
    var monthAsString: String = ""
    var monthAsInt: Int = 0
    var year: String = ""
    var isSelected: Bool = false
}
