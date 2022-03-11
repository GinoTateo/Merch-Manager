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
            Form{
            Section(header: Text("Account details")){
                List{
                    Text(user!.uid)
                    Text((user?.email!)!)
                    Text(userStore.currentUserInfo!.routeNumber)
                  }}.onAppear { self.getCurrUser() }
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                       ToolbarItem(placement: .principal) {
                           VStack {
                               Text("My \(dow)").font(.headline) .fixedSize(horizontal: true, vertical: false)
                               Text("Account").font(.subheadline)
                           
                           }
                       }
                    }
                }
            }
        }

    
    
//    private func createUserCreds(name: String, email: String, password: String)-> EmployeEntity{
//        let context = AccountPersistenceController.viewContext
//        let userdetails =
//        NSEntityDescription.insertNewObject(forEntityName: EmployeEntity, into: context)
//    }
    
    private func getCurrUser(){
        let db = Firestore.firestore()
        
        guard let userId = Auth.auth().currentUser?.uid else { return }
        let docRef = db.collection("User").document(userId)
        docRef.getDocument(source: .cache) { (document, error) in
          if let document = document {
            let name = document.get("FirstName")
            print("Cached document data: \(name)")
          } else {
            print("Document does not exist in cache")
          }
        }
    }

    
    
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
