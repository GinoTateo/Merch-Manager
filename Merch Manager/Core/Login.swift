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


struct Login: View {
    
// ------- Data ------- //
    //User
    @EnvironmentObject var userStore: UserStore
    
    var ref = Database.database().reference()

    @State var selectedUserIndex = 0
    @State var routeNumber = ""
    @State private var password: String = ""
    @State var showCreateAccount: Bool = false
    @State private var email: String = ""
    @State var ErrorMessage: Bool = false
    @State private var Authenticated: Bool = false
    
// ------- Body ------- //
    
    var body: some View {
            Form {
                Section(header: Text("User Details")) {
                    TextField("Email", text: $email)
                    SecureField("Password", text: $password)
                }
                
                Section(header: Text("Route")) {
                    TextField("Route Number", text: $routeNumber)
                        .keyboardType(.numberPad)
                    
                }
                Button("Login", action: {
                    withAnimation {
                    guard self.email != "" else {
                                    ErrorMessage = true
                                    ErrorHandler(errorType: email)
                                    return
                        }
                    guard self.password != "" else {
                                    ErrorHandler(errorType: password)
                                    return
                        }
                    guard self.routeNumber != "" else {
                                    ErrorHandler(errorType: routeNumber)
                                    return
                    }
                    do{
                        print("Begin day saved route #\(routeNumber)")
                        login()
                    }catch{
                        print(error.localizedDescription)
                    }
                }
            })
            .alert("Login Error", isPresented: $ErrorMessage) {
                Button("OK", role: .cancel) { }
                    }
                
                Section(header: Text("New user?")) {
                    Button("Creat new account ",action: {
                        withAnimation {
                        do {
                            print("Creating new account")
                            showCreateAccount.toggle()
                            }
                        catch {
                            print(error.localizedDescription)
                            }
                        }
                        })
                        .sheet(isPresented: $showCreateAccount) { CreateAccountView()}
                }
            }
         .navigationTitle(greeting())
    }
    
    
// ------- Functions ------- //
    
    private func login() {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                print(error?.localizedDescription ?? "")
            } else {
                print("success")
                let loggedUser = UserInfo.init(userName: email, email: email, routeNumber: routeNumber, authenticated: true,dow: GetWeekday())
                userStore.currentUserInfo = loggedUser
                Authenticated = true
                grabUserData()
            }
        }
    }
    
    private func grabUserData(){
        let db = Firestore.firestore()
        let UserId = (Auth.auth().currentUser?.uid)!
        let docRef = db.collection("User").document(UserId)

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                print("Document data: \(dataDescription)")
            } else {
                print("Document does not exist")
            }
        }
    }
    
    func ErrorHandler(errorType: String){
        if errorType == email {
            ErrorMessage = true
            print("Email Error")
        }
        if errorType == password{
            print("Password Error")
        }
        if errorType == routeNumber{
            print("Route Error")
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
    
    private func GetWeekday() -> String{
        let index = Foundation.Calendar.current.component(.weekday, from: Date()) // this returns an Int

        let weekdays = [ // Week days 0-6
            "Sunday",
            "Monday",
            "Tuesday",
            "Wednesday",
            "Thursday",
            "Friday",
            "Saturday"
        ]
        
        return weekdays[index-1] // Returns week day in String
        }
    
}
