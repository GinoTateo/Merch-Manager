//
//  StoreView.swift
//  Merch Manager
//
//  Created by Gino Tateo on 4/16/22.
//

import SwiftUI
import CoreData
import MapKit
import Firebase
import FirebaseFirestore


struct StoreView: View {
    
    //@EnvironmentObject var Locationstore: LocationStore
    var item: Store
    @EnvironmentObject var userStore: UserStore
    @ObservedObject var dateModelController = DateModelController()
    @State var numOfOOS = 0
    @State var numOfCases = 0
    @State private var date = Date()
    
    var ref = Database.database().reference()
    
    //    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: CLLocationManager().location?.coordinate.longitude ?? 0 , longitude: CLLocationManager().location?.coordinate.longitude  ?? 0), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    //

    
    struct Merch {
        let store, date: String
        let cases, OOS: Int
        let completed: Bool
    }
    var dates = [Merch]()
    
    
    var body: some View {
        
        VStack{
            
            //Map(coordinateRegion: $mapRegion)
            
            Form{
                Section(header: Text("Store")){
                    List{
                        HStack{
                            Text(item.name!)
                            Text(String(item.number))
                        }
                        Text(item.city!)
                        //                            Text("RSR Route #"+item.rsrnum!)
                        //                            Text("Merch Route #"+item.merchnum!)
                        
                    }
                }
            
            if ((userStore.currentUserInfo?.IsRSR) == true) {
                
                DatePicker(
                    "Start Date",
                    selection: $date,
                    in: ...Date(),
                    displayedComponents: [.date]
                )
                .datePickerStyle(.graphical)
                
            
                
                    Section(header: Text("Merch")){
                        List{
                            HStack{
                                Text("Out of Stocks").fontWeight(.light)
                                Spacer()
                                Text("\(numOfOOS)")
                            }
                            HStack{
                                Text("Cases").fontWeight(.light)
                                Spacer()
                                Text("\(numOfCases)")
                                
                            }
                        }
                    }
                }
            }
            
            
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                VStack {
                    Text(item.name!).font(.headline)
                    Text("Store View").font(.subheadline)
                }
            }
            
        }.refreshable {
            getMerch()
        }
        
    }
    
    
    func getMerch(){
        let db = Firestore.firestore()

        let formatteddate = date.formatted(.dateTime.day().month().year())
        
        let docRef = db.collection("Route").document(userStore.currentUserInfo?.routeNumber ?? "")
            .collection("LogCollection").document(formatteddate)

        docRef.getDocument { (document, error) in
            guard error == nil else {
                print("error", error ?? "")
                return
            }

            if let document = document, document.exists {
                let data = document.data()
                if let data = data {
                    print("data", data)
                    
                    _ = data["Complete Time"] as? String
                    _ = data["Complete"] as? Bool
                    numOfCases = data["Cases"] as? Int ?? 0
                    numOfOOS = data["OOS"] as? Int ?? 0
    
                   
                    
                }
            }

        }
        
    }
    
    
    
    func getMerchDetails(){
//        let db = Firestore.firestore()
//
//        let docRef = db.collection("Route").document(userStore.currentUserInfo?.routeNumber ?? "")
//            .collection("LogCollection").document(self.dateModelController.selectedDateFormatted)
//            .collection("StoreList").document(item.name!+String(item.number))
//
//        self.dateModelController.selectedDate
//
//        docRef.getDocument { (document, error) in
//            guard error == nil else {
//                print("error", error ?? "")
//                return
//            }
//
//            if let document = document, document.exists {
//                let data = document.data()
//                if let data = data {
//                    print("data", data)
//
//                    let CompTime = data["Complete Time"] as? String
//                    let Completed = data["Complete"] as? Bool
//                    let numOfCases = data["Cases"] as? Int ?? 0
//                    let numOfOOS = data["OOS"] as? Int ?? 0
//                    //let newMerch = Merch(store: item.name ?? "", date: CompTime ?? "", cases: numOfCases, OOS: numOfOOS, completed: Completed ?? true)
//                    //let test = Merch(store: "", date: "", cases: 0, OOS: 0, completed: true)
//                    //self.dates.append(test)
//
//                }
//
//            }
//
//        }
        
    }
    
    //struct StoreView_Previews: PreviewProvider {
    //    static var previews: some View {
    //        StoreView(store)
    //    }
    //}
}
