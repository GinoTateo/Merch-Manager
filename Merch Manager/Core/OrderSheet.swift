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
    //@EnvironmentObject var userScan: ScanStore
    
    var item: Store
    
    @Environment (\.presentationMode) var presentationMode
    @State var refresh: Bool = false
    
    @Environment(\.managedObjectContext) var OrderSheet
    
    //@Environment(\.managedObjectContext) var Items
    
//    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \ScannedList.barcode, ascending: true)])
//   private var list: FetchedResults<ScannedList>
    

    @Environment(\.managedObjectContext) private var AddItem

    @State var Complete = false
    @State var ScanMerch = false
    @State var ScanOOS = false
    @State var ViewScanned = false
    @State var Barcode = ""
    @State var logged = false
    
    @State var CaseCount = ""
    @State var OOSCount = ""
    
    var body: some View {
        VStack{
            List {
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
                
                if(Complete == true){
                    
                    Section(header: Text("Merch")) {
                        VStack{
                            TextField("Case count", text: $CaseCount)
                                .keyboardType(.numberPad)
                        }
                        VStack{
                            TextField("OOS count", text: $OOSCount)
                                .keyboardType(.numberPad)
                        }
                    }
                    
                    if(OOSCount > "0"){
                        Section(header: Text("OOS")) {
                            Button("Scan", action: {
                                withAnimation {


                                }
                            }).multilineTextAlignment(TextAlignment.center)
                                .foregroundColor(.brown)
                        }
                    }
                    Button("Complete", action: {
                        withAnimation {
                            item.plan = 0
                            presentationMode.wrappedValue.dismiss()
                            update()
                            completeLog()

                        }
                    }).multilineTextAlignment(TextAlignment.center)
                        .foregroundColor(.brown)
                    
                }else{
                    
                        Button("Begin", action: {
                            withAnimation {
                                BeginLog()
        
                            }
                        }).multilineTextAlignment(TextAlignment.center)
                        .foregroundColor(.brown)

                }
            }.navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        VStack {
                            Text("Store Merch").font(.headline)
                            Text("Order").font(.subheadline)
                        }
                    }
                }
        }
    }
    
    func update() {
       refresh.toggle()
    }
    
    func BeginLog(){
        let routeRef = db
            .collection("Route").document(userStore.currentUserInfo?.routeNumber ?? "")
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
//                let routeRef = db
//            .collection("User").document(Auth.auth().currentUser?.uid ?? "")
//            .collection("LogCollection").document(self.dateModelController.selectedDateFormatted)
//            .collection("StoreList").document(item.name!+String(item.number))
//            .collection("Merch").document(Barcode)
//            .setData([
//                    "Barcode": Barcode
//                ])
//
//
//            do {
//                presentationMode.wrappedValue.dismiss()
//                deleteList()
//            } catch {
//                print(error.localizedDescription)
//            }
        }

//    func AddItemsToOOS() {
//        let _: Void = db
//            .collection("Route").document(userStore.currentUserInfo?.routeNumber ?? "0")
//            .collection("LogCollection").document(self.dateModelController.selectedDateFormatted)
//            .collection("StoreList").document(item.name!+String(item.number))
//            .collection("OOS").document(list.barcode)
//            .addData([
//                
//                ])
//
//
//            do {
//                deleteList()
//            } catch {
//                print(error.localizedDescription)
//            }
//        }
    
    func completeLog(){
        
        let routeRef = db
            .collection("Route").document(userStore.currentUserInfo?.routeNumber ?? "")
            .collection("LogCollection").document(self.dateModelController.selectedDateFormatted)
            .collection("StoreList").document(item.name!+String(item.number)).setData(

                                    [
                                        "Complete Time": Date(),
                                        "Complete": true,
                                        "Cases" : CaseCount,
                                        "OOS": OOSCount,
                                    ]


                ) { err in
                    if let err = err {
                        print("Error writing document: \(err)")
                    } else {
                        print(self.dateModelController.selectedDateFormatted)
                        presentationMode.wrappedValue.dismiss()
                        Complete.toggle()
                        deleteList()
                    }
                }
            }
    
    func getScannedItems(){
//        let routeRef = db
//            .collection("User").document(Auth.auth().currentUser?.uid ?? "")
//            .collection("LogCollection").document(self.dateModelController.selectedDateFormatted)
//            .collection("StoreList").document(item.name!+String(item.number))
//            .collection("ProductUp").getDocuments { (snapshot, error) in
//
//                guard let snapshot = snapshot, error == nil else {
//                  //handle error
//                  return
//                }
//                print("Number of documents: \(snapshot.documents.count)")
//                snapshot.documents.forEach({ (documentSnapshot) in
//                    let documentData = documentSnapshot.data()
//                    let BarcodeData = documentData["Barcode"] as? String ?? ""
//
//
//                    print(BarcodeData)
//
//
//                    let newListItem = ScannedList(context: OrderSheet)
//                        newListItem.barcode = BarcodeData
//                        newListItem.itemRelation = Items(context: OrderSheet)
//                        newListItem.itemRelation?
//
//                    try? OrderSheet.save()
//                })
//
//            }
//        ViewScanned.toggle()
    }
    
    
    func deleteList(){
//
//        for item in list{
//            OrderSheet.delete(item)
//        }
//                do {
//                    try OrderSheet.save()
//                } catch {
//                    // Replace this implementation with code to handle the error appropriately.
//                    // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                    let nsError = error as NSError
//                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
        }
    
    func toggleScan(){
        ScanMerch.toggle()
    }
    
    
    }
        
