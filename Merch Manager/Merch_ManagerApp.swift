//
//  Merch_ManagerApp.swift
//  Merch Manager
//
//  Created by Gino Tateo on 11/5/21.
//

import SwiftUI
import Firebase
import FirebaseFirestore

@main
struct Merch_ManagerApp: App {
    let persistenceController = PersistenceController.shared
    let contentView = UserStore()
    let contentView2 = UserDay()
    let contentView3 = ScanStore()

    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    init (){
        let contentView = UserStore()
        let loggedUser = UserInfo.init(userName: "email", email: "email", routeNumber: "routeNumber", authenticated: false,dow: "Day of the week",firstName: "",lastName: "",postion: "",numStores: 0,currPlanPos: 0)
        contentView.currentUserInfo = loggedUser
        
        let contentView2 = UserDay()
        let loggedDay = DayData.init(beginDay: true, startTime: Date(), currStore: 0)
        contentView2.currentDay = loggedDay
        
        let contentView3 = ScanStore()
        let loggedScan = ScanList.init(numItem: 0, arrayItem: ["None"])
        contentView3.currentScan = loggedScan
    }


    var body: some Scene {
        WindowGroup {

            Home()
                .environmentObject(contentView)
                .environmentObject(contentView2)
                .environmentObject(contentView3)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)

        }
    }
}


class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        let db = Firestore.firestore()
        var ref: DatabaseReference!
        ref = Database.database().reference()
        return true
    }
}


