//
//  CreateAccountView.swift
//  Merch Manager
//
//  Created by Gino Tateo on 1/10/22.
//

import Foundation
import SwiftUI
import CoreData
import Firebase
import FirebaseFirestore


struct CreateAccountView: View{
    
    
    //Data to be saved
    @State private var userID: String = ""
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var Email: String = ""
    @State var position: String = ""
    @State private var password: String = ""
    @State var positionIndex: Int = 0
    
    let positionList = ["Merchandiser","Route Sales Representative", "Regional Manager", "Division Manager"]
    let db = Firestore.firestore()

    
    @Environment (\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) private var CreateAccountView


    var body: some View {
            Form {
                Section(header: Text("Login details")) {
                    VStack{
                        HStack{
                            TextField("User ID", text: $userID)
                        }
                    }
                    VStack{
                        HStack{
                            SecureField("Password", text: $password)
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
                }
                
                Section(header: Text("Position")) {
                    VStack{
                            Picker(selection: $positionIndex, label: Text("Position")) {
                                ForEach(0 ..< positionList.count) {
                                        Text(self.positionList[$0]).tag($0)
                            }
                        }
                    }
                }
                
                Button("Create Account",action: {
                    guard self.userID != "" else {return}

                    var ref: DocumentReference? = nil
                    ref = db.collection("User/").addDocument(data: [
                        "userID": userID,
                        "Email": Email,
                        "FirstName": firstName,
                        "LastName": lastName,
                        "Position": self.positionList[self.positionIndex]
                    ]) { err in
                        if let err = err {
                            print("Error adding document: \(err)")
                        } else {
                            print("Document added with ID: \(ref!.documentID)")
                        }
                    }
                    
                    Auth.auth().createUser(withEmail: Email, password: password) { authResult, error in
                      // ...
                    }
                    do {
                        presentationMode.wrappedValue.dismiss()
                    } catch {
                        print(error.localizedDescription)
                    }
                })
                
                
                
                

        }
    }
}
