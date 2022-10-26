//
//  ItemView.swift
//  Merch Manager
//
//  Created by Gino Tateo on 6/3/22.
//

import SwiftUI
import Foundation
import CoreData
import Firebase
import FirebaseFirestore
import MapKit

struct ItemView: View {
        @Environment(\.managedObjectContext) private var Service
   
    
    @State var openAddItem = false
   
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Items.name, ascending: true)])
   private var items: FetchedResults<Items>
    
    let db = Firestore.firestore()
    
    let formatter = NumberFormatter()
 //   let formatter.minimumFractionDigits = 0
//    formatter.maximumFractionDigits = 2
//    formatter.numberStyle = .decimal
    
    var body: some View {
  
        
            List {
               // ForEach(items) { item in
//
//                    NavigationLink(destination: ItemView2(Item: item)){
//                        HStack{
//
//                            Text(formatter.string(for: item.size) ?? "n/a").frame(alignment: .leading).font(.callout)
//                            Spacer()
//                            Text(item.name!).frame(alignment: .leading).font(.headline)
//                            Spacer()
//                            Text(item.type!).frame(alignment: .leading)
//
//
//                        }
//                    }
//                }.onDelete(perform: deleteItems)
            }.navigationBarTitleDisplayMode(.inline)
             .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("Items").font(.headline) .fixedSize(horizontal: true, vertical: false)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) { EditButton() }
            }
             .refreshable {
                             
                         }
            .navigationBarItems(trailing: Button(action: { addItem() }, label: { Image(systemName: "plus.circle")
                .imageScale(.large) }))
                .sheet(isPresented: $openAddItem) { AddItemView()}
    }
    
    
        private func deleteItems(offsets: IndexSet) {
            withAnimation {
                offsets.map { items[$0] }.forEach(Service.delete)
                
                    
                
                do {
                    try Service.save()
                } catch {
                    // Replace this implementation with code to handle the error appropriately.
                    // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    let nsError = error as NSError
                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
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
