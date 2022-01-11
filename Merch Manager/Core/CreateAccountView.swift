//
//  CreateAccountView.swift
//  Merch Manager
//
//  Created by Gino Tateo on 1/10/22.
//

import Foundation
import SwiftUI
import CoreData


struct CreateAccountView: View{
    
    
    //Data to be saved
    @State private var userID: String = "UserID"
    @State private var firstName: String = "First"
    @State private var lastName: String = "Last"
    @State private var Email: String = "Email"
    @State private var position: String = "Position"
    @State var positionIndex: Int = 0
    
    let positionList = ["Merchandiser","Route Sales Representative", "Regional Manager", "Division Manager"]
    
    @Environment (\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) private var CreateAccountView


    var body: some View {
            Form {
                Section(header: Text("User details")) {
                    VStack{
                        HStack{
                            TextField("User ID", text: $userID)
                        }
                    }
                }
                
                Section(header: Text("Name")) {
                    VStack{
                        HStack{
                            TextField("Name", text: $firstName)
                        }
                    }
                    VStack{
                        HStack{
                            TextField("Last Name", text: $lastName)
                        }
                    }
                }
                
                Section(header: Text("Email")) {
                    VStack{
                        HStack{
                            TextField("Email", text: $Email)
                        }
                    }
                    VStack{
                        HStack{
                            Picker(selection: $positionIndex, label: Text("Position")) {
                                ForEach(0 ..< positionList.count) {
                                        Text(self.positionList[$0]).tag($0)
                                }
                            }
                        }
                    }
                }
                    
                
                
                
                Button(action: {
                    guard self.userID != "" else {return}
                    let newAccount = EmployeEntity(context: CreateAccountView)
                        newAccount.name = firstName
                        
                        newAccount.title = self.positionList[self.positionIndex]
                    do {
                        try CreateAccountView.save()
                        presentationMode.wrappedValue.dismiss()
                    } catch {
                        print(error.localizedDescription)
                    }
                }) {
                    Text("Create Account")
                }

            }
    }
}
