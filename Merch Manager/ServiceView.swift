//
//  ServiceView.swift
//  Merch Manager
//
//  Created by Gino Tateo on 11/20/21.
//

import SwiftUI
import Foundation

struct Service: View {
        @Environment(\.managedObjectContext) private var Service

        @FetchRequest(
            sortDescriptors: [NSSortDescriptor(keyPath: \Store.name, ascending: true)],
            animation: .default)
    
    
        private var items: FetchedResults<Store>
        var dow = ""
    
    var body: some View {
        Text(dow).bold()
        NavigationView {
            List {
                ForEach(items) { item in
                    
                    NavigationLink {
                        NavigationView {
                            List{
                                    Text(item.name!).fontWeight(.bold)
                                    Text(String(item.number))
                                    Text(item.city!)
                                    Text(String(item.cases))
                                
                                }
                            }.toolbar {
                                ToolbarItem(placement: .navigationBarTrailing) {
                                EditButton()
                            }
                        }
                        
                    } label: {
                        Text(item.name!)
                    }
                }.onDelete(perform: deleteItems)
            }
            
        }.toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
            ToolbarItem {
                Button(action: addStore) {
                    Label("Add Item", systemImage: "plus")
                    
                }
            }
        }
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



                let newStore = Store(context: Service)
                    newStore.number = 1119
                    newStore.city = "Oakland"
                    newStore.cases = 10
                    newStore.name = "Safeway"
                
                
                
                
                
                
                
                
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
            Home().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext).previewInterfaceOrientation(.portrait)


        }
    }
}
