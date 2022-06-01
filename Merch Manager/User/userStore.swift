//
//  File.swift
//  Merch Manager
//
//  Created by Gino Tateo on 2/15/22.
//

import Combine
import FirebaseFirestore
import Foundation

class UserStore: ObservableObject {
  @Published var currentUserInfo: UserInfo?
}

class Dow: ObservableObject {
  @Published var currentdow: dow?
}

class LocationStore: ObservableObject {
  @Published var currentLocationInfo: LocationInfo?
}

class RouteData: ObservableObject {
  @Published var currentRouteInfor: StoreData?
}
