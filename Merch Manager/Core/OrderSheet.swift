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
import CarBode
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

    @State var Complete = false
    @State var ScanIt = false
    @State var ViewScanned = false
    @State var Barcode = ""
    
    var body: some View {
       
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
            Form {
                Section(header: Text("Scanned Items")) {
                    Button("View Scanned Items", action: {
                        withAnimation {
                            ViewScanned.toggle()
                            getScannedItems()
                        }
                    })
                    if(ViewScanned == true){
                        VStack{
                            List{

                            }
                        }
                    }
                }
            }
        
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
                    
                    
                    NavigationLink("Scan Merch", destination: ScanView(item: item))
                        .padding()
                        .frame(height: 45)
                        .font(.headline)
                        .background(Color.accentColor)
                        .foregroundColor(Color.white)
                        .cornerRadius(15)
                    
                }
                
            
        }
    }       .navigationBarTitleDisplayMode(.inline)
            .toolbar {
              ToolbarItem(placement: .principal) {
                  VStack {
                      Text("Store Merch").font(.headline)
                      Text("Order").font(.subheadline)
                  }
              }
          }
      }
    
    func updateLog(){
        
        let logScan = ScanList.init(numItem: 0, arrayItem: [])
        userScan.currentScan = logScan
        
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
    
    func AddItemsToLog() {
                let routeRef = db
            .collection("User").document(Auth.auth().currentUser?.uid ?? "")
            .collection("LogCollection").document(self.dateModelController.selectedDateFormatted)
            .collection("StoreList").document(item.name!+String(item.number))
            .collection("ProductUp").document(Barcode)
            .setData([
                    "Barcode": Barcode
                ])
            

            do {
                presentationMode.wrappedValue.dismiss()
            } catch {
                print(error.localizedDescription)
            }
        }

    func AddItemsToOOS() {
                let routeRef = db
            .collection("User").document(Auth.auth().currentUser?.uid ?? "")
            .collection("LogCollection").document(self.dateModelController.selectedDateFormatted)
            .collection("StoreList").document(item.name!+String(item.number))
            .collection("oos").document(Barcode)
            .setData([
                    "Barcode": Barcode
                ])
            

            do {
                presentationMode.wrappedValue.dismiss()
            } catch {
                print(error.localizedDescription)
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
    
    func getScannedItems(){
        let routeRef = db
            .collection("User").document(Auth.auth().currentUser?.uid ?? "")
            .collection("LogCollection").document(self.dateModelController.selectedDateFormatted)
            .collection("StoreList").document(item.name!+String(item.number))
            .collection("ProductUp").getDocuments { (snapshot, error) in
                
                guard let snapshot = snapshot, error == nil else {
                  //handle error
                  return
                }
                snapshot.documents.forEach({ (documentSnapshot) in
                    let documentData = documentSnapshot.data()
                    let BarcodeData = documentData["Barcode"] as? String
                })
        
            }
    }
    
}

    
