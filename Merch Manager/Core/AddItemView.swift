//
//  ItemView.swift
//  Merch Manager
//
//  Created by Gino Tateo on 6/2/22.
//

import Foundation
import SwiftUI
import CoreData
import Firebase
import FirebaseFirestore
import CarBode
import AVFoundation


struct AddItemView: View {
        let db = Firestore.firestore()
        
        @Environment (\.presentationMode) var presentationMode
        @Environment(\.managedObjectContext) private var AddItem
        @EnvironmentObject var userStore: UserStore
    
    @State var ItemName = ""
    @State var Size = 0
    @State var ItemType = 0
    @State var Barcode = ""
    @State var Brand = 0
    @State var ScanIt = false
    @State var Name = 0
    
    @State var bigbag: Int16 = 18
    @State var smallbag: Int16 = 10

    let BagSizeList  = [10,12,18,10,22,32,48]
    let KSizeList = ["10","22","32","48"]
    let TypeList = ["Ground","Whole Bean","K-Cup","Capsule"]
    let BrandList = ["Peets","Intelligentsia","Stumptown"]
    let NameList = ["Major Dickason’s Blend®","French Roast","Big Bang®","Café Domingo","Organic French Roast","Luminosa Breakfast Blend","Alameda Morning Blend","House Blend","Single Origin Brazil","Single Origin Colombia","Organic Decaf Terrena (Water Processed)","Decaf Major","Decaf House Blend","Decaf French Roast","Organic Alma de la Tierra","Italian Roast","Single Origin Costa Rica","Caramel Brulée","Vanilla Cinnamon","Hazelnut Mocha","Sumatra",]
    
        var body: some View {
            VStack{
                NavigationView {
                        Form {
                            Section(header: Text("Add Item")) {
                                    VStack{
                                        HStack{
                                            Picker(selection: $Brand, label: Text("Brand")) {
                                                ForEach(0 ..< BrandList.count) {
                                                        Text(self.BrandList[$0]).tag($0)
                                                }
                                            }
                                        }
                                    }
                                    VStack{
                                        HStack{
                                            Picker(selection: $Name, label: Text("Name")) {
                                                ForEach(0 ..< NameList.count) {
                                                        Text(self.NameList[$0]).tag($0)
                                                }
                                            }
                                        }
                                    }
                                    VStack{
                                        HStack{
                                            Picker(selection: $ItemType, label: Text("Type")) {
                                                ForEach(0 ..< TypeList.count) {
                                                        Text(self.TypeList[$0]).tag($0)
                                                }
                                            }
                                        }
                                    }
                                    VStack{
                                        HStack{
                                            Picker(selection: $Size, label: Text("Size")) {
                                                if(ItemType==0||ItemType==1){
                                                    ForEach(0 ..< BagSizeList.count) {
                                                        let stringValue = String(format: "%.1f", BagSizeList[$0])
                                                            Text(stringValue).tag($0)
                                                    }
                                                }else{
                                                        ForEach(0 ..< KSizeList.count) {
                                                                Text(self.KSizeList[$0]).tag($0)
                                                        }
                                                    }
                                            }
                                        }
                                    }

                                VStack{
                                        Button(action: {
                                            ScanIt.toggle()
                                        }){
                                            Text("Scan Barcode").bold()
                                        }
                                    
                                }

                            }
                                    
                            }
                             .navigationBarTitleDisplayMode(.inline)
                              .toolbar { // <2>
                                ToolbarItem(placement: .principal) { // <3>
                                    VStack {
                                        Text("My \(userStore.currentUserInfo!.dow)").font(.headline) .fixedSize(horizontal: true, vertical: false)
                                        Text("Add Item").font(.subheadline)
                                }
                            }
                        }
                    }
                }
            VStack{
                if (ScanIt == true){
                    
                    CBScanner(
                        supportBarcode: .constant([.ean13]), //Set type of barcode you want to scan
                            scanInterval: .constant(5.0) //Event will trigger every 5 seconds
                        ){
                            //When the scanner found a barcode
                            print("BarCodeType =",$0.type.rawValue, "Value =",$0.value)
                            Barcode = $0.value
                            if Barcode.hasPrefix("0"){
                                let index = Barcode.index(Barcode.startIndex, offsetBy: 1)
                                Barcode = Barcode.substring(from: index)
                            }
                            ScanIt = false
                            Addit()
                        }
                    
                }
            }
                
            VStack{
                Button(action: Addit) {
                    Text("Add Item").bold().padding().font(.headline)
                }
            }
        
//        func updateItems(){
//
//            var newcount = userStore.currentUserInfo?.numStores
//            newcount!+=1
//            userStore.currentUserInfo?.numStores = newcount!
//
//            let UserId = (Auth.auth().currentUser?.uid)!
//            db.collection("User/").document(UserId).setData(
//
//                                    [
//                                        "numStores": newcount!
//                                    ]
//
//
//            ) { err in
//                if let err = err {
//                    print("Error writing document: \(err)")
//                } else {
//                    print("Document successfully written!")
//                }
//            }
//
//
//
//    }
  }
    
    
    func Addit() {
            let newItem = Items(context: AddItem)
            newItem.name = NameList[Name]
            newItem.brand = BrandList[Brand]
            newItem.size = bigbag //=--------------------> 18 oz hard coded
            newItem.barcode = Barcode
            newItem.type = TypeList[ItemType]


                let routeRef = db
                    .collection("Items").document("\(BrandList[Brand])")
                    .collection("\(BagSizeList[Size])").document(Barcode).setData([
                    "Name": NameList[Name],
                    "Brand": BrandList[Brand],
                    "Type": TypeList[ItemType],
                    "Size": BagSizeList[Size],
                    "Barcode": Barcode,
                ])
            

            do {
                try AddItem.save()
                //updateNumStores()
                presentationMode.wrappedValue.dismiss()
            } catch {
                print(error.localizedDescription)
            }
        }

}

