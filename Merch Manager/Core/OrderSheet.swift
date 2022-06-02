//
//  OrderSheet.swift
//  Merch Manager
//
//  Created by Gino Tateo on 11/19/21.
//

import Foundation
import SwiftUI
import CoreData
import Firebase
import FirebaseFirestore
import AVFoundation


struct OrderSheet: View {
       
    @EnvironmentObject var userStore: UserStore
    @EnvironmentObject var userDay: UserDay
    @ObservedObject var dateModelController = DateModelController()
    let db = Firestore.firestore()
    @EnvironmentObject var userScan: ScanStore
    
    var item: Store
    
    @Environment (\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) private var OrderSheet
    
    @State private var isPresentingScanner = false
    @State private var scannedCode: String?

    @State var Complete = false
    
    var body: some View {
       
        VStack{
           
            if(Complete == false){
                HStack{
                    Button("Begin Merch", action: {
                        withAnimation {
                            updateLog()
                        }
                    })
                        .padding()
                        .frame(height: 45)
                        .font(.headline)
                        .background(Color.accentColor)
                        .foregroundColor(Color.white)
                        .cornerRadius(15)
  
                }
            }else{
                HStack{
                Button("Complete Merch", action: {
                    withAnimation {
                        completeLog()
                    }
                })
                    .padding()
                    .frame(height: 45)
                    .font(.headline)
                    .background(Color.accentColor)
                    .foregroundColor(Color.white)
                    .cornerRadius(15)
                    
                    
                    NavigationLink("Scan Merch", destination: ScanView(), isActive: $isPresentingScanner)
                        .padding()
                        .frame(height: 45)
                        .font(.headline)
                        .background(Color.accentColor)
                        .foregroundColor(Color.white)
                        .cornerRadius(15)
                    
                }
                }
            
        

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
                }
                
            }
    }
             .navigationBarTitleDisplayMode(.inline)
              .toolbar { // <2>
                ToolbarItem(placement: .principal) { // <3>
                    VStack {
                        Text("Store Merch").font(.headline)
                        Text("Order").font(.subheadline)
                    }
                }

        
    }
    }
    
    func updateLog(){
        let routeRef = db
            .collection("User").document(Auth.auth().currentUser?.uid ?? "")
            .collection("LogCollection").document(self.dateModelController.selectedDateFormatted)
            .collection("StoreList").document(item.name!+String(item.number)).setData(

                                    [
                                        "Arrival Time": Date(),
                                    ]
                                        

                ) { err in
                    if let err = err {
                        print("Error writing document: \(err)")
                    } else {
                        print(self.dateModelController.selectedDateFormatted)
                        Complete.toggle()
                    }
                }
            }
    
    func completeLog(){
        let routeRef = db
            .collection("User").document(Auth.auth().currentUser?.uid ?? "")
            .collection("LogCollection").document(self.dateModelController.selectedDateFormatted)
            .collection("StoreList").document(item.name!+String(item.number)).setData(

                                    [
                                        "Complete Time": Date(),
                                        "Complete": true
                                    ]


                ) { err in
                    if let err = err {
                        print("Error writing document: \(err)")
                    } else {
                        print(self.dateModelController.selectedDateFormatted)
                        presentationMode.wrappedValue.dismiss()
                        Complete.toggle()
                    }
                }
            }
    
    
}

    
