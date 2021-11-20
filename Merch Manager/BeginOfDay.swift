//
//  BeginOfDay.swift
//  Merch Manager
//
//  Created by Gino Tateo on 11/19/21.
//

import Foundation
import SwiftUI


struct BeginOfDay: View {
    
    let pizzaTypes = ["Gino Tateo",
                      "Amanda Tateo",
                      "Nicole Tateo",
                      "Angela Tateo"]
    
    
    
    @State var selectedPizzaIndex = 1
    @State var numberOfSlices = 1
    @State var tableNumber = ""
    @State private var password: String = ""
    
    @Environment (\.presentationMode) var presentationMode
    
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("User Details")) {
                    Picker(selection: $selectedPizzaIndex, label: Text("User")) {
                        ForEach(0 ..< pizzaTypes.count) {
                                Text(self.pizzaTypes[$0]).tag($0)
                        }
                    }
                    
                    SecureField("Password", text: $password)
                }
                
                Section(header: Text("Route")) {
                    TextField("Route Number", text: $tableNumber)
                        .keyboardType(.numberPad)
                    
                }
                
                Button(action: {
                    guard self.tableNumber != "" else {return}
                    do {
                        print("Begin day saved.")
                        presentationMode.wrappedValue.dismiss()
                    } catch {
                        print(error.localizedDescription)
                    }
                }) {
                    Text("Login")
                }
            }
                .navigationTitle(greeting())
        }
    }
    
    
    
    
    private func greeting() -> String{
        let hour = Calendar.current.component(.hour, from: Date())
        
        if hour < 12 {
            return "Good Morning, "
        }
        if hour > 12 && hour < 15{
            return "Good Afternoon, "
        }
        if hour > 15{
            return "Good Evening, "
        }
        else{
            return "Hello, "
        }
    }
    
}
