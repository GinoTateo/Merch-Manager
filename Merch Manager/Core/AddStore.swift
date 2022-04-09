//
//  AddStore.swift
//  Merch Manager
//
//  Created by Gino Tateo on 12/10/21.
//

import Foundation
import SwiftUI
import CoreData
import Firebase
import FirebaseFirestore

struct AddStore: View {
    
    @State var StoreName: String = ""
    @State var City = ""
    @State var StoreNumber = ""
    @State var dos = ""
    @State var RepRoute = ""
    @State var MerchRoute = ""
    @State var dosIndex = 0
    var dow = ""
    
    let DayOfWeek = ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"]
    
    let db = Firestore.firestore()
    
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
                            TextField("Route Number", text: $RepRoute)
                                .keyboardType(.numberPad)
                        }
                    }
                    VStack{
                        HStack{
                            TextField("Merch Number", text: $MerchRoute)
                                .keyboardType(.numberPad)
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
                    
                    

                    var ref: DocumentReference? = nil
                    ref = db.collection("Store").addDocument(data: [
                        "Name": StoreName,
                        "Number": StoreNumber,
                        "MerchRoute": MerchRoute,
                        "City": City,
                        "StoreCity": self.DayOfWeek[self.dosIndex]
                    ]) { err in
                        if let err = err {
                            print("Error adding document: \(err)")
                        } else {
                            print("Document added with ID: \(ref!.documentID)")
                        }
                    }

                    
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
                        Text("My \(dow)").font(.headline) .fixedSize(horizontal: true, vertical: false)
                        Text("Add Store").font(.subheadline)
                    }
                }
            }
        }
    }
}
