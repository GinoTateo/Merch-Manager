//
//  CreatePlanView.swift
//  Merch Manager
//
//  Created by Gino Tateo on 4/26/22.
//

import SwiftUI
import Firebase
import FirebaseFirestore


struct CreatePlanView: View {
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Store.plan, ascending: true)])
    private var items: FetchedResults<Store>
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \PlanList.plan, ascending: true)])
    private var list: FetchedResults<PlanList>

    @ObservedObject var dateModelController = DateModelController()
    
    @Environment (\.presentationMode) var presentationMode
    
    @EnvironmentObject var userStore: UserStore
    
    
    
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
                        }
                       .onTapGesture {
                           
                       }
                    
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
//                let email = document.get("Email") as? String ?? ""
//                let position = document.get("Position")as? String ?? ""
//                let route = document.get("RouteNumber") as? String ?? ""
//                let numstores = document.get("numStores") as? Int ?? 0
//
//                let loggedUser = UserInfo.init(userName: email, email: email, routeNumber: route, authenticated: true,dow: GetWeekday(), firstName: first, lastName: last, postion: position,numStores: 0, currPlanPos: 0)
//                userStore.currentUserInfo = loggedUser

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
    
    
    func loadStoresIn(){
        
        let db = Firestore.firestore()

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

                        
//                        let newStore = Store(context: AddStore)
//                        newStore.number = Number ?? 0
//                        newStore.city = City
//                        newStore.name = Name
//                        newStore.plan = Plan ?? 0
//                        newStore.longitude = Long ?? 0
//                        newStore.latitude = Lat ?? 0
                        
                        }
                    )
                }
            }
    }
    
    
}
