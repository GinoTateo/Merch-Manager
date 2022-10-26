//
//  AccountView.swift
//  Merch Manager
//
//  Created by Gino Tateo on 12/15/21.
//

import SwiftUI
import CoreData
import Firebase




struct AccountView: View {
    
    var dow = ""
    @EnvironmentObject var userStore: UserStore
    
    
    var user = Auth.auth().currentUser
    
    
    var body: some View {
        
        if(userStore.currentUserInfo?.authenticated==true){
            VStack{
                Form{
                    Section(header: Text("Representative")){
                        List{
                            HStack{
                                Text(userStore.currentUserInfo!.firstName)
                                Text(userStore.currentUserInfo!.lastName)
                            }
                        }
                    }
                    
                    Section(header: Text("Account details")){
                        List{
                            Text(user!.uid)
                            Text(userStore.currentUserInfo!.email)
                        }
                    }
                    Section(header: Text("Route number")){
                        List{
                            HStack{
                                Text(userStore.currentUserInfo!.postion)
                                Text(userStore.currentUserInfo!.routeNumber)
                            }
                        }
                    }
                        Button("Toggle RSR", action: {
                            withAnimation {
                                togglrsr()
                            }
                        }).multilineTextAlignment(TextAlignment.center)
                            .foregroundColor(.brown)

                    Button("Logout", action: {
                        withAnimation {
                            logout()
                        }
                    }).multilineTextAlignment(TextAlignment.center)
                        .foregroundColor(.brown)
                        
                    
                           }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("Account").font(.subheadline)
                        
                    }
                }
            }
        }
    }
    
    private func togglrsr(){
        userStore.currentUserInfo?.IsRSR.toggle()
    }
    
    
    
    //    private func createUserCreds(name: String, email: String, password: String)-> EmployeEntity{
    //        let context = AccountPersistenceController.viewContext
    //        let userdetails =
    //        NSEntityDescription.insertNewObject(forEntityName: EmployeEntity, into: context)
    //    }
    //
    //    private func getCurrUser(){
    //        let db = Firestore.firestore()
    //
    //        guard let userId = Auth.auth().currentUser?.uid else { return }
    //        let docRef = db.collection("User").document(userId)
    //        docRef.getDocument(source: .cache) { (document, error) in
    //          if let document = document {
    //            let name = document.get("FirstName")
    //            print("Cached document data: \(name)")
    //          } else {
    //            print("Document does not exist in cache")
    //          }
    //        }
    //    }
    
    
    
    
    
    
    func logout(){
        
        let loggedUser = UserInfo.init(userName: "", email: "", routeNumber: "", authenticated: false,dow: "",firstName: "",lastName: "",postion: "",numStores: 0, currPlanPos: 0, IsRSR: false)
        userStore.currentUserInfo = loggedUser
        
        
        
        
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
        
    }
    
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
