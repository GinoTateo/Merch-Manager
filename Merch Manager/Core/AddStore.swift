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
    //@State var dow = 0
    @State var dosIndex = 0
    var dow = ""
    
    let DayOfWeek = ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"]
    
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
                            TextField("Store City", text: $City)
                        }
                    }
                    VStack{
                        HStack{
                            Picker(selection: $dosIndex, label: Text("Day of week")) {
                                ForEach(0 ..< DayOfWeek.count) {
                                        Text(self.DayOfWeek[$0]).tag($0)
                                }
                            }
                        }
                    }
                    
                }
                
                
                Button(action: {
                    guard self.StoreNumber != "" else {return}
                    let newStore = Store(context: AddStore)
                        newStore.number = Int16(self.StoreNumber)!
                        newStore.city = City
                        //newStore.dow = 0
                        newStore.name = StoreName
                        newStore.dos = self.DayOfWeek[self.dosIndex]
                    do {
                        try AddStore.save()
                        presentationMode.wrappedValue.dismiss()
                    } catch {
                        print(error.localizedDescription)
                    }
                }) {
                    Text("Add store")
                }

            }
             .navigationBarTitleDisplayMode(.inline)
              .toolbar { // <2>
                ToolbarItem(placement: .principal) { // <3>
                    VStack {
                        Text("My \(dow)").font(.headline)
                        Text("Add Store").font(.subheadline)
                    }
                }
            }
        }
    }
}
