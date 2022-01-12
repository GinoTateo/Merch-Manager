//
//  BeginOfDay.swift
//  Merch Manager
//
//  Created by Gino Tateo on 11/19/21.
//

import Foundation
import SwiftUI
import CoreData
import Firebase


struct BeginOfDay: View {
    
    @Binding var showBeginSheet: Bool
    @State var selectedUserIndex = 0
    @State var routeNumber = ""
    @State private var password: String = ""
    @State var showCreateAccount: Bool = false
    @State private var email: String = ""
    
    @Environment (\.presentationMode) var presentationMode
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \EmployeEntity.userID, ascending: true)],
        animation: .default)
    private var Users: FetchedResults<EmployeEntity>
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("User Details")) {
                    TextField("Email", text: $email)
                    SecureField("Password", text: $password)
                }
                
                Section(header: Text("Route")) {
                    TextField("Route Number", text: $routeNumber)
                        .keyboardType(.numberPad)
                    
                }
                
                Button(action: {
                    guard self.email != "" else {return}
                    guard self.password != "" else {return}
                    guard self.routeNumber != "" else {return}
                    do {
                        print("Begin day saved route #\(routeNumber)")
                        login()
                        
                        
                    } catch {
                        print(error.localizedDescription)
                    }
                }) {
                    Text("Login")
                }
                Section(header: Text("New user?")) {
                    Button("Creat new account ",action: {
                        do {
                            print("Creating new account")
                            showCreateAccount.toggle()
                
                        } catch {
                            print(error.localizedDescription)
                        }
                    }).sheet(isPresented: $showCreateAccount) { CreateAccountView()}

                }
            }
                .navigationTitle(greeting())
        }
    }
    
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                print(error?.localizedDescription ?? "")
            } else {
                print("success")
                showBeginSheet = false
                presentationMode.wrappedValue.dismiss()
            }
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
