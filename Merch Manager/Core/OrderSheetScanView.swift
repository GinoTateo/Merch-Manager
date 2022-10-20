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

struct OrderSheetScanView: View {
    
    @State var Barcode = ""
    @State var Scanned = false
    @FocusState var focusedField: Bool
    @Environment (\.presentationMode) var presentationMode
    @State var InputNum: Int16 = 6
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \ScannedList.barcode, ascending: true)])
   private var list: FetchedResults<ScannedList>
    @Namespace var mainNamespace
    
    @Environment(\.managedObjectContext) private var OrderSheetScanView
    
    var body: some View {
        VStack{
            if(Scanned==true){
                Text("Scanned \(Barcode)").bold().padding().font(.headline)
                
                Section(header: Text("Amount")) {
                    
                    TextField("Enter your score", value: $InputNum, format: .number)
                        .keyboardType(.numberPad)
                }
                
                Spacer()
                
                Button("Confirm", action: {
                    withAnimation {
                        do{
                            presentationMode.wrappedValue.dismiss()
                            createlist()
                            print("Closing Scan View")
                        }catch{
                            print(error.localizedDescription)
                        }
                    }
                })
                
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
        let newList = ScannedList(context: OrderSheetScanView)
            newList.barcode = Barcode
            newList.numItems = InputNum
        
    }
}

