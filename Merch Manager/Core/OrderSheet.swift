//
//  OrderSheet.swift
//  Merch Manager
//
//  Created by Gino Tateo on 11/19/21.
//

import Foundation
import SwiftUI
import CoreData


struct OrderSheet: View {
       
    var dow = ""
    var item: Store
    
    @Environment (\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) private var OrderSheet
    
    @State var selectedPizzaIndex = 1
    @State var numberOfSlices = 1
    @State var CaseCount = ""
    
    var body: some View {
            Form {
                Section(header: Text("Store Details")) {
                    VStack{
                        HStack{
                    Text(item.name!).fontWeight(.light)
                    Text(String(item.number)).fontWeight(.light)
                        }
                    }
                    VStack{
                        HStack{
                        Text(item.city!+", CA").fontWeight(.light)
                        }
                    }
                    VStack{
                        HStack{
                        Text(item.dos!).fontWeight(.light)
                        }
                    }
                    
                }
                
//                Section(header: Text("Case count")) {
//                    TextField("Number of cases", text: $CaseCount)
//                        .keyboardType(.numberPad)
//
//                }
//
//                Button(action: {
//                    guard self.CaseCount != "" else {return}
//                    let newOrder = Store(context: OrderSheet)
//                    newOrder.number = Int16(self.StoreNumber)!
//                    newOrder.city = City
//                    do {
//                        try OrderSheet.save()
//                        presentationMode.wrappedValue.dismiss()
//                    } catch {
//                        print(error.localizedDescription)
//                    }
//                }) {
//                    Text("Add store")
//                }
            }
             .navigationBarTitleDisplayMode(.inline)
              .toolbar { // <2>
                ToolbarItem(placement: .principal) { // <3>
                    VStack {
                        Text("My \(dow)").font(.headline)
                        Text("Order").font(.subheadline)
                    }
                }

        }
    }
}
