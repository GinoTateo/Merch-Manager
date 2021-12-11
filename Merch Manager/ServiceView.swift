//
//  ServiceView.swift
//  Merch Manager
//
//  Created by Gino Tateo on 11/20/21.
//

import SwiftUI
import Foundation
import CoreData

struct Service: View {
        @Environment(\.managedObjectContext) private var Service
   
        var dow = ""
    @State var openAddStore = false

   
   @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Store.dos, ascending: true)])//,predicate: NSPredicate(format: "dos == Sunday"))

    private var items: FetchedResults<Store>
    
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
                ToolbarItem(placement: .navigationBarTrailing) {
                                    EditButton()
                                }
            }
            .navigationBarItems(trailing: Button(action: { addStore() }, label: {
                                Image(systemName: "plus.circle")
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
                
//                let newStore = Store(context: Service)
//                    newStore.number = 3132
//                    newStore.city = "Oakland"
//                    newStore.dow = 0
//                    newStore.name = "Safeway"
//                    newStore.dos = "Sunday"
                
                openAddStore = true
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
    
    
    
    
    
    private func grabStores(){
        let index = Foundation.Calendar.current.component(.weekday, from: Date()) // this returns an Int
      
    }
    
    

        
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()


struct Service_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Service().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext).previewInterfaceOrientation(.portrait)


        }
    }
}
