//
//  ItemView2.swift
//  Merch Manager
//
//  Created by Gino Tateo on 11/8/22.
//

import SwiftUI
import Foundation
import CoreData
import Firebase
import FirebaseFirestore

struct ItemView2: View {
        @Environment(\.managedObjectContext) private var Service
   
    
    @State var openAddItem = false
   

    
    let db = Firestore.firestore()
    
    var body: some View {
        
        
        Section(header: Text("Item")){
            List{
                HStack{
                    
                    
                }
            }
            
        }
        
    }

        
        private func addItem() {
            withAnimation {
                openAddItem = true
                
            }
        }
    
//        private func grabStores() {
//            let docRef = db.document("Store")
//
//            // Force the SDK to fetch the document from the cache. Could also specify
//            // FirestoreSource.server or FirestoreSource.default.
//            docRef.getDocument { (document, error) in
//                if let document = document, document.exists {
//                    let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
//                    print("Document data: \(dataDescription)")
//                } else {
//                    print("Document does not exist")
//                }
//            }
//            print(docRef)
//        }
         
}
