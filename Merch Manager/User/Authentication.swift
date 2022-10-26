//
//  AuthenticationStatus.swift
//  Merch Manager
//
//  Created by Gino Tateo on 2/16/22.
//

import Firebase
import Foundation
import SwiftUI
import CoreData

class AuthenticationViewModel: ObservableObject {

  enum SignInState {
    case signedIn
    case signedOut
  }

  @Published var state: SignInState = .signedOut
  @EnvironmentObject var userStore: UserStore

    func signOut() {
      do {
        try Auth.auth().signOut()
          state = .signedOut
      } catch {
        print(error.localizedDescription)
      }
    }

    
//    func login(email: String,password: String, routeNumber: String) {
//        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
//            if error != nil {
//                print(error?.localizedDescription ?? "")
//            } else {
//                print("successful login")
//                self.state = .signedIn
//                let loggedUser = UserInfo.init(userName: email, email: email, routeNumber: routeNumber, authenticated: true,)
//                self.userStore.currentUserInfo = loggedUser
//            }
//        }
//    }
}

//func fetchUserData(documentId: String) {
//    let db = Firestore.firestore()
//  let docRef = db.collection("books").document(documentId)
//
//  docRef.getDocument { document, error in
//    if let error = error as NSError? {
//      self.errorMessage = "Error getting document: \(error.localizedDescription)"
//    }
//    else {
//      if let document = document {
//        do {
//          UserStore.userName = try document.data(as: UserStore.self)
//        }
//        catch {
//          print(error)
//        }
//      }
//    }
//  }
//}


//var ref: DocumentReference? = nil
//ref = db.collection("User/").document(userID)
//
//                        data: [
//                        "userID": userID,
//                        "Email": Email,
//                        "FirstName": firstName,
//                        "LastName": lastName,
//                        "Position": self.positionList[self.positionIndex]
//                        ]
//) { err in
//    if let err = err {
//        print("Error adding document: \(err)")
//    } else {
//        print("Document added with ID: \(ref!.documentID)")
//    }
//}
