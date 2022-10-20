//
//  WarehouseOrderSheet.swift
//  Merch Manager
//
//  Created by Gino Tateo on 7/27/22.
//

import Foundation
import SwiftUI
import CoreData
import Firebase
import FirebaseFirestore
import CarBode
import AVFoundation




struct WarehouseOrderSheet: View {
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Order.date, ascending: true)])
    private var orders: FetchedResults<Order>
    
    @EnvironmentObject var userStore: UserStore
    @EnvironmentObject var userDay: UserDay
    @Environment (\.presentationMode) var presentationMode
    @ObservedObject var dateModelController = DateModelController()
    let db = Firestore.firestore()
    @EnvironmentObject var userScan: ScanStore
    
    @State var Barcode = ""
    @State var showOrderForm = false
    
    @State var newItem = ""
    
    
    let WarehouseLocation = ["Concord", "Cotati"]
    @State var WarehouseIndex = 0
    
    let WarehouseTime = ["9:30", "10:00","11:00","12:00"]
    @State var TimeIndex = 0
    
    
    var body: some View {
        
Text("Choose Pick-Up Time & Location")
        Form {
            Section(header: Text("Pick-Up")) {
                
                VStack{
                    HStack{
                        Picker(selection: $WarehouseIndex, label: Text("Location")) {
                            ForEach(0 ..< WarehouseLocation.count) {
                                    Text(self.WarehouseLocation[$0]).tag($0)
                            }
                        }
                    }
                }
                
                VStack{
                    HStack{
                        Picker(selection: $TimeIndex, label: Text("Time")) {
                            ForEach(0 ..< WarehouseTime.count) {
                                    Text(self.WarehouseTime[$0]).tag($0)
                            }
                        }
                    }
                }
            }
            
            
            
            
            
            
        }
            
        Spacer()
        
        VStack{            
            Button("Start Order",action: {
                withAnimation {
                do {
                    print("Start Order")
                    showOrderForm.toggle()
                    CreateOrderData()
                    }
                catch {
                    print(error.localizedDescription)
                        }
                    }
                }
            )
                .sheet(isPresented: $showOrderForm) { WarehouseOrderForm() }
                //.bold().padding().font(.headline)
            
        }
            
        
    }
    
    
    func CreateOrderData(){
        
//        let newOrder = Order(context: WarehouseOrderSheet)
//            newOrder.date = Date()
//            newOrder.id = UUID()
        
        
        db.collection("Warehouse/").document("\(WarehouseIndex)")
            .collection("\(userStore.currentUserInfo?.routeNumber ?? "0")").document(self.dateModelController.selectedDateFormatted).setData(
            
                [ "Pickup-time" : WarehouseTime[TimeIndex], "Location " : WarehouseLocation[WarehouseIndex]]
                                
        
        ) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
                    
                //presentationMode.wrappedValue.dismiss()
            }
        }
    }

}


struct WarehouseOrderSheet_Previews: PreviewProvider {
    static var previews: some View {
        WarehouseOrderSheet()
    }
}
