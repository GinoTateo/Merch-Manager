//
//  AccountView.swift
//  Merch Manager
//
//  Created by Gino Tateo on 12/15/21.
//

import SwiftUI
import CoreData



struct AccountView: View {
    
    var dow = ""
    @Environment(\.managedObjectContext) private var PlanDay
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \EmployeEntity.name, ascending: true)],
        animation: .default)
    private var user: FetchedResults<EmployeEntity>

    
    var body: some View {
        
    
        
        List {
            Text("Hello")
        }.navigationBarTitleDisplayMode(.inline)
         .toolbar {
            ToolbarItem(placement: .principal) {
                VStack {
                    Text("My \(dow)").font(.headline)
                    Text("Plan day").font(.subheadline)
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                                EditButton()
                            }
        }

        
        
    }
    
//    private func createUserCreds(name: String, email: String, password: String)-> EmployeEntity{
//        let context = AccountPersistenceController.viewContext
//        let userdetails =
//        NSEntityDescription.insertNewObject(forEntityName: EmployeEntity, into: context)
//    }

    
    
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
