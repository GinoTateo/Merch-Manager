//
//  PlanDay.swift
//  Merch Manager
//
//  Created by Gino Tateo on 12/15/21.
//

import SwiftUI
import CoreData
import Foundation



struct PlanDay: View {
    
    @Environment(\.managedObjectContext) private var PlanDay

    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Store.dos, ascending: true)])//,predicate: NSPredicate(format: "dos == Sunday"))

     private var items: FetchedResults<Store>
    
    var dow = ""
    
    
    var body: some View {
        
        List {
            ForEach(items) { item in
                
                   HStack{
                        Spacer()
                        Text(item.name!)
                        Text(String(item.number))
                        Spacer()
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
//        .navigationBarItems(trailing: Button(action: { addStore() }, label: {
//                            Image(systemName: "plus.circle")
//            .imageScale(.large) }))
//        .sheet(isPresented: $openAddStore) { AddStore(dow: dow)}

}
    
    
    
    
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(PlanDay.delete)

            do {
                try PlanDay.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct PlanDay_Previews: PreviewProvider {
    static var previews: some View {
        PlanDay()
    }
}
