//
//  ServiceView.swift
//  Merch Manager
//
//  Created by Gino Tateo on 11/20/21.
//

import SwiftUI
import Foundation
import CoreData
import Firebase
import FirebaseFirestore

struct Service: View {
        @Environment(\.managedObjectContext) private var Service
        var dow = ""
   
    @State var openAddStore = false
   
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Store.dos, ascending: true)])//,predicate: NSPredicate(format: "dos == Sunday"))

   private var items: FetchedResults<Store>
    
    let db = Firestore.firestore()
    
    var body: some View {
  
            List {
                ForEach(items) { item in
                    
                    NavigationLink(destination: OrderSheet(dow: dow,item: item)){
                        HStack{
                            Spacer()
                            Text(item.name!)
                            Text(String(item.number))
                            Spacer()
                        }
                    }
                }.onDelete(perform: deleteItems)
            }.navigationBarTitleDisplayMode(.inline)
             .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("My \(dow)").font(.headline)
                            Text("Store list").font(.subheadline)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) { EditButton() }
            }
            .navigationBarItems(trailing: Button(action: { addStore() }, label: { Image(systemName: "plus.circle")
                .imageScale(.large) }))
                .sheet(isPresented: $openAddStore) { AddStore(dow: dow)}
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
        
        private func addStore() {
            withAnimation {
                openAddStore = true
                
            }
        }
    
        private func grabStores() {
            let docRef = db.document("Store")

            // Force the SDK to fetch the document from the cache. Could also specify
            // FirestoreSource.server or FirestoreSource.default.
            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                    print("Document data: \(dataDescription)")
                } else {
                    print("Document does not exist")
                }
            }
            print(docRef)
        }
         
}
