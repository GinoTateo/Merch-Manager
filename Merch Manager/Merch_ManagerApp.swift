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

    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    init (){
        let contentView = UserStore()
        let loggedUser = UserInfo.init(userName: "email", email: "email", routeNumber: "routeNumber", authenticated: false,dow: "Day of the week")
        contentView.currentUserInfo = loggedUser
    }

    var body: some Scene {
        WindowGroup {

            Home()
                .environmentObject(contentView)
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


