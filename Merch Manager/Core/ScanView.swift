//
//  ScanView.swift
//  Merch Manager
//
//  Created by Gino Tateo on 6/2/22.
//

import SwiftUI
import AVFoundation
import CarBode


struct ScanView: View {
    
    @Environment (\.presentationMode) var presentationMode
    @EnvironmentObject var userScan: ScanStore
    
    var body: some View {
        

        
        
        
        CBScanner(
                supportBarcode: .constant([.qr, .code128]), //Set type of barcode you want to scan
                scanInterval: .constant(5.0) //Event will trigger every 5 seconds
            ){
                //When the scanner found a barcode
                print("BarCodeType =",$0.type.rawValue, "Value =",$0.value)
                presentationMode.wrappedValue.dismiss()
                
            }
        
    }
}

