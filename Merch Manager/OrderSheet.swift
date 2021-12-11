//
//  OrderSheet.swift
//  Merch Manager
//
//  Created by Gino Tateo on 11/19/21.
//

import Foundation
import SwiftUI


struct OrderSheet: View {
       
    var dow = ""
    var item: Store
    
    @State var selectedPizzaIndex = 1
    @State var numberOfSlices = 1
    @State var tableNumber = ""
    
    var body: some View {
        NavigationView {
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
                
                Section(header: Text("Table")) {
                    TextField("Table Number", text: $tableNumber)
                        .keyboardType(.numberPad)
                    
                }
                
                Button(action: {
                    guard self.tableNumber != "" else {return}

                }) {
                    Text("Add Order")
                }
            }
            } .navigationBarTitleDisplayMode(.inline)
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
