//
//  ScanView.swift
//  Merch Manager
//
//  Created by Gino Tateo on 6/2/22.
//

import SwiftUI
import AVFoundation
import CarBode
import FirebaseFirestore
import Firebase
import CoreData

struct ScanView: View {
    
    @Environment (\.presentationMode) var presentationMode
    @EnvironmentObject var userScan: ScanStore
    
    @State var Barcode = ""
    @State var Scanned = false
    let db = Firestore.firestore()
    
    @ObservedObject var dateModelController = DateModelController()
    
    @Environment(\.managedObjectContext) var Items
    
    var body: some View {
        VStack{
            if(Scanned==true){
                Text("Scanned \(Barcode)").bold().padding().font(.headline)
            }
        }
        CBScanner(
            supportBarcode: .constant([.ean13]), //Set type of barcode you want to scan
                scanInterval: .constant(7.5) //Event will trigger every 5 seconds
        ){
            //When the scanner found a barcode
            AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate)) { }
            print("BarCodeType =",$0.type.rawValue, "Value =",$0.value)
            Scanned = true
            Barcode = $0.value
            if Barcode.hasPrefix("0"){
                let index = Barcode.index(Barcode.startIndex, offsetBy: 1)
                Barcode = Barcode.substring(from: index)
            }
            
        }
        
        VStack{
            Button(action: doneButton){
                
                Text("Done").bold().padding().font(.headline)
            }
        }
        
    }
    
     func doneButton(){
        presentationMode.wrappedValue.dismiss()
    }
    
    
}
