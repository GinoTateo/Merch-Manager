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
import FirebaseFirestore



struct Login: View {
    
// ------- Data ------- //
    //User
    @EnvironmentObject var userStore: UserStore
    @EnvironmentObject var planDayData: PlanDayData
    
    @Environment(\.managedObjectContext) private var AddStore
    @Environment(\.managedObjectContext) private var PlanDay
    
    var ref = Database.database().reference()

    @State var selectedUserIndex = 0
    @State var routeNumber = ""
    @State private var password: String = ""
    @State var showCreateAccount: Bool = false
    @State private var email: String = ""
    @State var ErrorMessage: Bool = false
    @State private var Authenticated: Bool = false
    
    @State var errorText: String  = ""
    
// ------- Body ------- //
    
    var body: some View {
        
        Image("icons8-open-box-64")
        
            Form {
                Section(header: Text("User Details")) {
                    TextField("Email", text: $email)
                        .textContentType(.username)
                        .disableAutocorrection(true)
                    SecureField("Password", text: $password)
                        .textContentType(.password)
                        .disableAutocorrection(true)
                }
                
                Section(header: Text("Route")) {
                    TextField("Route Number", text: $routeNumber)
                        .keyboardType(.numberPad)
                    
                }
                Button("Login", action: {
                    withAnimation {
                    guard self.email != "" else {
                                    
                                    ErrorHandler(errorType: email)
                        ErrorMessage = true
                                    return
                        }
                    guard self.password != "" else {
                                    
                                    ErrorHandler(errorType: password)
                        ErrorMessage = true
                                    return
                        }
                    guard self.routeNumber != "" else {
                                
                                    ErrorHandler(errorType: routeNumber)
                        ErrorMessage = true
                                    return
                    }
                    do{
                        print("Begin day saved route #\(routeNumber)")
                        login()
                        loadStoresIn()
                    }catch{
                        ErrorHandler(errorType: email)
                        ErrorMessage = true
                        print(error.localizedDescription)
                    }
                }
            })
            .alert("Login Error", isPresented: $ErrorMessage) {
                Button("OK", role: .cancel) {
                    Text(errorText)
                }
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
                        }
                    )
                        .sheet(isPresented: $showCreateAccount) { CreateAccountView()}
                }
            }
         //.navigationTitle(greeting())
    }
    
    
// ------- Functions ------- //
    
    private func login() {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                print(error?.localizedDescription ?? "")
                ErrorMessage = true;
            } else {
                print("success")
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
 
                let first = document.get("FirstName") as? String ?? ""
                let last = document.get("LastName") as? String ?? ""
                let email = document.get("Email") as? String ?? ""
                let position = document.get("Position")as? String ?? ""
                let route = document.get("RouteNumber") as? String ?? ""
                let numstores = document.get("numStores") as? Int ?? 0
                
                let loggedUser = UserInfo.init(userName: email, email: email, routeNumber: route, authenticated: true,dow: GetWeekday(), firstName: first, lastName: last, postion: position,numStores: numstores, currPlanPos: 0)
                userStore.currentUserInfo = loggedUser

            } else {
                print("Document does not exist")

                let UserId = (Auth.auth().currentUser?.uid)!
                db.collection("User/").document(UserId).setData(

                                        [
                                        "userID": UserId,
                                        "Email": email,
                                        "FirstName": "firstName",
                                        "LastName": "lastName",
                                        "RouteNumber": routeNumber,
                                        "Position": "Merchandiser"
                                        ]


                ) { err in
                    if let err = err {
                        print("Error writing document: \(err)")
                    } else {
                        print("Document successfully written!")
                    }
                }
            }
        }
    }
    
    
    func loadStoresIn(){                
        
        let db = Firestore.firestore()

        let routeRef = db               // Get referance
            .collection("Route").document("Merchandiser")
            .collection(routeNumber).getDocuments { (snapshot, error) in
        
                guard let snapshot = snapshot, error == nil else {
                  //handle error
                  return
                }
                
                let count = snapshot.documents.count - 1

                if((userStore.currentUserInfo?.numStores ?? 0)!==count){
                    print("Number of documents: \(snapshot.documents.count ?? -1)")
                    snapshot.documents.forEach({ (documentSnapshot) in
                      let documentData = documentSnapshot.data()
                      let Name = documentData["Name"] as? String
                      let Number = documentData["Number"] as? Int16
                      let City = documentData["City"] as? String
                      let Plan = documentData["Plan"] as? Int16
                        let Long = documentData["Longitude"] as? Double
                        let Lat = documentData["Latitude"] as? Double

                        
                        let newStore = Store(context: AddStore)
                        newStore.number = Number ?? 0
                            newStore.city = City
                            newStore.name = Name
                        newStore.plan = Plan ?? 0
                        newStore.longitude = Long ?? 0
                        newStore.latitude = Lat ?? 0
                        
                        }
                    )
                }
        }
    }
    
    func ErrorHandler(errorType: String){
        if errorType == email {
            errorText = "Email Error"
            print("Email Error")
        }
        if errorType == password{
            errorText = "Password Error"
            print("Password Error")
        }
        if errorType == routeNumber{
            errorText = "Route Error"
            print("Route Error")
        }
        ErrorMessage = true
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
