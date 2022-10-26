//
//  ViewMerch.swift
//  Merch Manager
//
//  Created by Gino Tateo on 10/26/22.
//

import SwiftUI
import CoreData
import Firebase
import FirebaseFirestore

struct ViewMerch: View {
    
    @EnvironmentObject var userStore: UserStore
    @Environment(\.managedObjectContext) private var AddStore
    

    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Store.plan, ascending: true)])
    private var items: FetchedResults<Store>

    var ref = Database.database().reference()
    
    var body: some View {
        
                  List {
                      ForEach(items) { item in
                          
                          NavigationLink(destination: StoreView(item: item)){
                              HStack{
                                  Spacer()
                                  Text(item.name!)
                                  Text(String(item.number))
                                  Spacer()
                              }
                          }
                      }
                  }.navigationBarTitleDisplayMode(.inline)
                   .toolbar {
                      ToolbarItem(placement: .principal) {
                          VStack {
                                  Text("Store list").font(.subheadline)
                          }
                      }
                      ToolbarItem(placement: .navigationBarTrailing) { EditButton() }
                  }
                   .refreshable {
                                   loadStoresIn()
                               }
                
    }
    
    
    func loadStoresIn(){
//
//        let db = Firestore.firestore()
//
//        let routeRef = db               // Get referance
//            .collection("Route").document("Merchandiser")
//            .collection(routeNumber).getDocuments { (snapshot, error) in
//
//                guard let snapshot = snapshot, error == nil else {
//                  //handle error
//                  return
//                }
//
//                //Get Num stores in data base
//                let count = snapshot.documents.count - 1
//
//                print("Num stores \(userStore.currentUserInfo?.numStores))")
//                // Compare to num of stores in User Account
//                if((userStore.currentUserInfo?.numStores ?? 0)>=count){
//                     print(userStore.currentUserInfo!.numStores )
//                    print("Number of documents: \(snapshot.documents.count-1)")
//                } else {
//                    snapshot.documents.forEach({ (documentSnapshot) in
//                      let documentData = documentSnapshot.data()
//                      let Name = documentData["Name"] as? String
//                      let Number = documentData["Number"] as? Int16
//                      let City = documentData["City"] as? String
//                      let Plan = documentData["Plan"] as? Int16
//                      let Long = documentData["Longtitude"] as? Double //Spelling error
//                      let Lat = documentData["Latitude"] as? Double
//
//                        print("Loading stores in")
//
//                        let newStore = Store(context: AddStore)
//                        newStore.number = Number ?? 0
//                        newStore.city = City
//                        newStore.name = Name
//                        newStore.plan = Plan ?? 0
//                        newStore.longitude = Long ?? 0
//                        newStore.latitude = Lat ?? 0
//
//                        }
//                    )
//                userStore.currentUserInfo?.numStores = count
//            }
//        }
    }
    
}

struct ViewMerch_Previews: PreviewProvider {
    static var previews: some View {
        ViewMerch()
    }
}
