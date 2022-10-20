//
//  StartRouteView.swift
//  Merch Manager
//
//  Created by Gino Tateo on 12/15/21.
//

import SwiftUI
import CoreData
import Firebase
import FirebaseFirestore
import MapKit
import MessageUI


struct Dashboard: View {
    
    @Environment(\.managedObjectContext) private var Dashboard
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Store.dos, ascending: true)])
    private var items: FetchedResults<Store>
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.83500, longitude: -122.24871), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))

    @EnvironmentObject var userStore: UserStore
    @EnvironmentObject var userDay: UserDay
    @ObservedObject var dateModelController = DateModelController()
    let db = Firestore.firestore()
    
    @State var result: Result<MFMailComposeResult, Error>? = nil
    @State var isShowingMailView = false
    @State var test = "false"
    
    var body: some View {
        
        
            VStack{
            if((userDay.currentDay?.beginDay) == false){
                Spacer()
                Image("z0uy2c")
                Image("gkonp9")
                Spacer()
                HStack{
                    Button("Begin Route", action: {
                        withAnimation {
                            BeginDay()
                        }
                    }).font(.system(size: 20, weight: .light , design: .rounded))
                        .multilineTextAlignment(TextAlignment.center)
                        .foregroundColor(.brown)
                        .frame(width: 150, height: 50)
                        .overlay { RoundedRectangle(cornerRadius: 10.0)
                                .stroke(.white, lineWidth: 2.0)
                        }
                    
                }
            }else{
                Spacer()
                List {
                    ForEach(items) { item in
                        if item.plan > 0 {
                            NavigationLink(destination: OrderSheet(item: item)){
                                HStack{
                                    Spacer()
                                    Text(item.name!)
                                    Text(String(item.number))
                                    Spacer()
                                }
                            }
                            .swipeActions(allowsFullSwipe: false) {
                                Button {
                                    print("Skipping")
                                } label: {
                                    Label("Skip", systemImage: "chevron.right.2")
                                }
                                .tint(.blue)
                                
                                Button(role: .destructive) {
                                    print("Deleting conversation")
                                } label: {
                                    Label("Delete", systemImage: "trash.fill")
                                }
                            }
                        
                        }
                    }
                }

                
                Button("Complete Route", action: {
                    withAnimation {
                        CompleteDay()
                        
                        print(generateReports())
                        test = generateReports()
                        print(test)
                    }
                }).font(.system(size: 20, weight: .light , design: .rounded))
                    .multilineTextAlignment(TextAlignment.center)
                    .foregroundColor(.brown)
                    .frame(width: 150, height: 50)
                    .overlay { RoundedRectangle(cornerRadius: 10.0)
                            .stroke(.white, lineWidth: 2.0)
                    }
                    .disabled(!MFMailComposeViewController.canSendMail())
                    .sheet(isPresented: $isShowingMailView) {
                        MailView(result: self.$result, messageBody: test)
                    }
            }
        }
        
        
        
.navigationBarTitleDisplayMode(.inline)
.toolbar {
    ToolbarItem(placement: .principal) {
        VStack {
            Text("My \(userStore.currentUserInfo!.dow)").font(.headline) .fixedSize(horizontal: true, vertical: false)
            Text("Dashboard").font(.subheadline)
        }
    }
}
        
    }



    func BeginDay(){
        print("Begin Day")
        let loggedDay = DayData.init(beginDay: true, startTime: Date(), currStore: 0)
        userDay.currentDay = loggedDay
        
        
    let routeRef = db
        .collection("Route").document(userStore.currentUserInfo?.routeNumber ?? "")
        .collection("LogCollection").document(self.dateModelController.selectedDateFormatted).setData(
            
            
            
            // Need a way of adding data from list to list

                                [
                                    "Begin Day": userDay.currentDay?.beginDay,
                                    "Start Time": userDay.currentDay?.startTime,
                                ]


            ) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print(self.dateModelController.selectedDateFormatted)
                }
            }
        
    }
    
    func CompleteDay(){
        print("Complete Day")
        let routeRef = db
            .collection("Route").document(userStore.currentUserInfo?.routeNumber ?? "")
            .collection("LogCollection").document(self.dateModelController.selectedDateFormatted).setData(
                
                
                
                // Need a way of adding data from list to list

                                    [
                                        "EOD": Date()
                                    ]


                ) { err in
                    if let err = err {
                        print("Error writing document: \(err)")
                    } else {
                        print(self.dateModelController.selectedDateFormatted)
                    }
                }
        
        isShowingMailView.toggle()
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(Dashboard.delete)

            do {
                try Dashboard.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    func generateReports() -> (String) {
        var store = "store"
        var Cases = 0
        var Complete = false
        var CompleteTime = Date()
        var OOS = 0
        
            let db = Firestore.firestore()
    
            let routeRef = db               // Get referance
            .collection("Route").document(userStore.currentUserInfo?.routeNumber ?? "")
            .collection("LogCollection").document(self.dateModelController.selectedDateFormatted)
            .collection("StoreList").getDocuments { (snapshot, error) in
    
                    guard let snapshot = snapshot, error == nil else {
                      //handle error
                      return
                    }
    
                    //Get Num stores in data base
                    let count = snapshot.documents.count - 1
                
                
                
                        snapshot.documents.forEach({ (documentSnapshot) in
                            
                        store = documentSnapshot.documentID
                            print(store)
                            
                          let documentData = documentSnapshot.data()
                            
                            Cases = documentData["Cases"] as? Int ?? 0
                            Complete = documentData["Complete"] as? Bool ?? false
                            //CompleteTime = (documentData["Complete Time"] as? Date)!
                            OOS = documentData["OOS"] as? Int ?? 0
                            
                            
                        })
                }
        
        return (store)
    }
    
    
}

