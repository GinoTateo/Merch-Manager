//
//  OrderSheet.swift
//  Merch Manager
//
//  Created by Gino Tateo on 11/19/21.
//

import Foundation
import SwiftUI


struct OrderSheet: View {
       
    let pizzaTypes = ["Pizza Margherita", "Greek Pizza", "Pizza Supreme", "Pizza California", "New York Pizza"]
    
    
    
    @State var selectedPizzaIndex = 1
    @State var numberOfSlices = 1
    @State var tableNumber = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Pizza Details")) {
                    Picker(selection: $selectedPizzaIndex, label: Text("Pizza Type")) {
                        ForEach(0 ..< pizzaTypes.count) {
                                Text(self.pizzaTypes[$0]).tag($0)
                        }
                    }
                    
                    Stepper("\(numberOfSlices) Slices", value: $numberOfSlices, in: 1...12)
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
                .navigationTitle("Add Order")
        }
    }
}
