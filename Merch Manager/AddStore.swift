//
//  AddStore.swift
//  Merch Manager
//
//  Created by Gino Tateo on 12/10/21.
//

import Foundation
import SwiftUI
import CoreData

struct AddStore: View {
    
    @State var StoreName: String = ""
    @State var City = ""
    @State var StoreNumber = ""
    @State var dos = ""
    @State var dow = 0
    
    @Environment (\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) private var AddStore
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Store Details")) {
                    VStack{
                        HStack{
                            TextField("Store Name", text: $StoreName)
                        }
                    }
                    VStack{
                        HStack{
                            TextField("Store Number", text: $StoreNumber)
                                .keyboardType(.numberPad)
                        }
                    }
                    VStack{
                        HStack{
                        Text(StoreNumber).fontWeight(.light)
                        }
                    }
                    
                }
                
                Section(header: Text("Table")) {
                    //TextField("Table Number", text: $tableNumber)
                    //    .keyboardType(.numberPad)
                    
                }
                
                Button(action: {
                    //guard self.routeNumber != "" else {return}
                    do {
                        let newStore = Store(context: AddStore)
                            newStore.number = 0
                            newStore.city = ""
                            newStore.dow = 0
                            newStore.name = StoreName
                            newStore.dos = "Sunday"
                        presentationMode.wrappedValue.dismiss()
                    } catch {
                        print(error.localizedDescription)
                    }
                }) {
                    Text("Add store")
                }

            }
            } .navigationBarTitleDisplayMode(.inline)
              .toolbar { // <2>
                ToolbarItem(placement: .principal) { // <3>
                    VStack {
                        //Text("My \(dow)").font(.headline)
                        Text("Order").font(.subheadline)
                    }
                }

        }
    }
}
