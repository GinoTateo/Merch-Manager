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
}
struct CreatePlanView_Previews: PreviewProvider {
    static var previews: some View {
        CreatePlanView()
    }
}
