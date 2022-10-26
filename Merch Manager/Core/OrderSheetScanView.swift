//
//  OrderSheetScanView.swift
//  Merch Manager
//
//  Created by Gino Tateo on 9/2/22.
//

import SwiftUI
import CarBode
import AVFoundation
import Foundation
import CoreData
import Firebase
import FirebaseFirestore

struct OrderSheetScanView: View {
    
    @State var Barcode = ""
    @State var Scanned = false
    @FocusState var focusedField: Bool
    @Environment (\.presentationMode) var presentationMode
    @State var InputNum = 6
    @State var scanNum = 0
    @State var ScanComplete = false
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \ScannedList.barcode, ascending: true)])
    private var list: FetchedResults<ScannedList>
    @Namespace var mainNamespace
    @ObservedObject var dateModelController = DateModelController()
    @EnvironmentObject var userStore: UserStore
    @Environment(\.managedObjectContext) private var OrderSheetScanView
    let db = Firestore.firestore()
    
    var numoos: String
    var currStore: String
    
    var body: some View {
        VStack{
            if(Scanned==true){
                
                Text("Scanned \(Barcode)").bold().padding().font(.headline)
                VStack{
                    List{
                        Section(header: Text("Amount")) {
                            
                            TextField("Number of items", value: $InputNum, format: .number)
                                .keyboardType(.numberPad)
                        }
                        
                        
                        
                        if scanNum >= (Int(numoos) ?? 0){
                            Button("Confirm", action: {
                                withAnimation {
                                    do{
                                        presentationMode.wrappedValue.dismiss()
                                        scanNum = 0
                                        createlist()
                                        print("scan num \(scanNum) -- Done")
                                    }catch{
                                        print(error.localizedDescription)
                                    }
                                }
                            }).frame(maxWidth: .infinity, alignment: .center).padding()
                        } else {
                            Button("Next", action: {
                                withAnimation {
                                    do{
                                        createlist()
                                        Scanned = false
                                        print("scan num \(scanNum)")
                                    }catch{
                                        print(error.localizedDescription)
                                    }
                                }
                            }).frame(maxWidth: .infinity, alignment: .center).padding()
                        }
                    }
                }
                
            }
            else{
                CBScanner(
                    supportBarcode: .constant([.ean13]), //Set type of barcode you want to scan
                    scanInterval: .constant(7.5) //Event will trigger every 5 seconds
                ){
                    //When the scanner found a barcode
                    AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate)) { }
                    print("BarCodeType =",$0.type.rawValue, "Value =",$0.value)
                    Scanned = true
                    scanNum += 1
                    Barcode = $0.value
                    if Barcode.hasPrefix("0"){
                        let index = Barcode.index(Barcode.startIndex, offsetBy: 1)
                        Barcode = Barcode.substring(from: index)
                        
                        
                    }
                    
                }
            }
        }
    }
    
    
    func createlist(){
        let routeRef = db
            .collection("Route").document(userStore.currentUserInfo?.routeNumber ?? "")
            .collection("LogCollection").document(self.dateModelController.selectedDateFormatted)
            .collection("StoreList").document(currStore)
            .collection("OOS").document(Barcode).setData(
                
                [
                    "IsOOS": true,
                ]
                
                
            ) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print(self.dateModelController.selectedDateFormatted)
                }
            }
    }
}
