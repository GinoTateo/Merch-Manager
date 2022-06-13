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

struct ScanView: View {
    
    @Environment (\.presentationMode) var presentationMode
    @EnvironmentObject var userScan: ScanStore
    
    @State var Barcode = ""
    @State var Scanned = false
    let db = Firestore.firestore()
    
    var item: Store
    @ObservedObject var dateModelController = DateModelController()
    
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
                print("BarCodeType =",$0.type.rawValue, "Value =",$0.value)
                let Scanned = true
                Barcode = $0.value
                if Barcode.hasPrefix("0"){
                    let index = Barcode.index(Barcode.startIndex, offsetBy: 1)
                    Barcode = Barcode.substring(from: index)
                }
            
            let routeRef = db
            .collection("User").document(Auth.auth().currentUser?.uid ?? "")
            .collection("LogCollection").document(self.dateModelController.selectedDateFormatted)
            .collection("StoreList").document(item.name!+String(item.number))
            .collection("ProductUp").document(Barcode)
            .setData([
                    "Barcode": Barcode
                ])
                let Scanned = false
            }onDraw: {
                //line width
                let lineWidth = 2

                //line color
                let lineColor = UIColor.red

                //Fill color with opacity
                //You also can use UIColor.clear if you don't want to draw fill color
                let fillColor = UIColor(red: 0, green: 1, blue: 0.2, alpha: 0.4)

                //Draw box
                $0.draw(lineWidth: CGFloat(lineWidth), lineColor: lineColor, fillColor: fillColor)
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

