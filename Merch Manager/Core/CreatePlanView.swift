//
//  CreatePlanView.swift
//  Merch Manager
//
//  Created by Gino Tateo on 4/26/22.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import CoreData


struct CreatePlanView: View {
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Store.plan, ascending: true)])
    private var items: FetchedResults<Store>
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \PlanList.plan, ascending: true)])
    private var list: FetchedResults<PlanList>
    
//    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Plan.date, ascending: true)])
//    private var plan: FetchedResults<Plan>

    @ObservedObject var dateModelController = DateModelController()
    
    @Environment (\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) private var CreatePlan
    @EnvironmentObject var userStore: UserStore
    
    let db = Firestore.firestore()
    
    
    var body: some View {

        VStack {
            Text("Please choose a delivery date.").font(.title).bold()
            ScrollView(.horizontal, showsIndicators: false, content: {
                HStack(spacing: 10) {
                    ForEach(dateModelController.listOfValidDates, id: \.self) { date in
                        GridView(date: date).onTapGesture {
                            
                            self.dateModelController.toggleIsSelected(date: date)
                        
                        }
                        
                    }
                    
                }
                
            })
            Spacer()
                HStack {
                    Text("Delivery overview: ")
                    Text("\(self.dateModelController.selectedDate)").foregroundColor(.green).bold()
                }.padding(.top, 20)
            List {
                ForEach(items) { item in
                    
                       HStack{
                           Text(String(item.plan))
                            Spacer()
                            Text(item.name!)
                            Text(String(item.number))
                            Spacer()
                        }.swipeActions(allowsFullSwipe: false) {
                            Button {
                                print("1")
                                addToLog(item: item.name ?? "")
                                
                                
                            } label: {
                                Label("1", systemImage: "1.circle")
                            }
                            .tint(.blue)
                            
                            Button {
                                print("3")
                                addToLog(item: "\(item.name ?? " ")\(item.number)")
                            } label: {
                                Label("3", systemImage: "3.circle")
                            }
                            
                            Button {
                                print("5")
                                addToLog(item: "\(item.name ?? " ")\(item.number)")
                            } label: {
                                Label("5", systemImage: "5.circle")
                            }
                            
                            
                        }
                }.onTapGesture{
                   
                }
                
                
            }
            

            Button("Create", action: {
                    LogPlanCollection()
            })
                    .font(.system(size: 30, weight: .semibold , design: .rounded))
                    .foregroundColor(.black)
                    .multilineTextAlignment(TextAlignment.center)
                    
            
        }.padding().padding(.top, 30)
        
    }
    
    func AddToPlan(at offsets: IndexSet){
        
    }

    func LogPlanCollection(){
        
        let db = Firestore.firestore()

        let docRef = db
            .collection("User").document(Auth.auth().currentUser?.uid ?? "")
            .collection("LogCollection").document(self.dateModelController.selectedDateFormatted)

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                print("Document data: \(dataDescription)")
 
//                let first = document.get("FirstName") as? String ?? ""
//                let last = document.get("LastName") as? String ?? ""

            } else {
        let routeRef = db
            .collection("User").document(Auth.auth().currentUser?.uid ?? "")
            .collection("LogCollection").document(self.dateModelController.selectedDateFormatted).setData(
                
                
                
                // Need a way of adding data from list to list

                                    [
                                        "numStores": userStore.currentUserInfo?.numStores,
                                    "storeList": [
                                                "Route/Merchandiser/14/38obzZ8fPXfLRXY8maGK",
                                                "Route/Merchandiser/14/hXS3UJ2pGlijZFO5gcxW",
                                                "Route/Merchandiser/14/sxnVgud7sihcSKf3otQK",
                                        ]
                                    ]


                ) { err in
                    if let err = err {
                        print("Error writing document: \(err)")
                    } else {
                        print(self.dateModelController.selectedDateFormatted)
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
    
    func addToLog(item: String){
        
        
        
        
        
//        let routeRef = db
//            .collection("User").document(Auth.auth().currentUser?.uid ?? "")
//            .collection("LogCollection").document(self.dateModelController.selectedDateFormatted)
//            .collection("StoreList").document(item).setData(
//
//                                    [
//                                        "Complete": false,
//                                    ]
//
//
//                ) { err in
//                    if let err = err {
//                        print("Error writing document: \(err)")
//                    } else {
//                        print(self.dateModelController.selectedDateFormatted)
//                    }
//                }
            }
    
    func loadStoresIn(){
        let routeRef = db               // Get referance
            .collection("Route").document("Merchandiser")
            .collection(userStore.currentUserInfo?.routeNumber ?? "").getDocuments { (snapshot, error) in
        
                guard let snapshot = snapshot, error == nil else {
                  //handle error
                  return
                }
                
                let count = snapshot.documents.count - 1

                if((userStore.currentUserInfo?.numStores)==count){
                    print(userStore.currentUserInfo!.numStores )
                    print("Number of documents: \(snapshot.documents.count-1)")
                } else {
                    snapshot.documents.forEach({ (documentSnapshot) in
                      let documentData = documentSnapshot.data()
                      let Name = documentData["Name"] as? String
                      let Number = documentData["Number"] as? Int16
                      let City = documentData["City"] as? String
                      let Plan = documentData["Plan"] as? Int16
                      let Long = documentData["Longtitude"] as? Double //Spelling error
                      let Lat = documentData["Latitude"] as? Double
                      let complete = documentData["Complete"] as? Bool

                        
//                        let newStore = PlanList(context: CreatePlan)
//                        newStore.number = Number ?? 0
//                        newStore.city = City
//                        newStore.name = Name
//                        newStore.plan = Plan ?? 0
//                        newStore.complete = complete ?? false
//                        newStore.longitude = Long ?? 0
//                        newStore.latitude = Lat ?? 0
                        
//                                                let newplan = plan(context: CreatePlan)
//                                                newplan.date = Date()
//                        newplan.stores = Store(context: CreatePlan)
//                        newplan.stores?.Store =
                        
                        }
                    )
                }
            }
    }
    
    
}
