//
//  WarehouseOrderForm.swift
//  Merch Manager
//
//  Created by Gino Tateo on 7/31/22.
//

import SwiftUI

struct WarehouseOrderForm: View {
    
    @Environment (\.presentationMode) var presentationMode
    @EnvironmentObject var userStore: UserStore
    @ObservedObject var dateModelController = DateModelController()
    
    //@EnvironmentObject var books: Book
    
    var body: some View {
        NavigationView {
            VStack{
                //Section(header: Text("Brands")){
                    List{
                       
                        VStack{
                            NavigationLink(destination: WarehouseOrderItem(brand: "Peet's", order: "peets")){
                                HStack{
                                    Text("Peet's")
                                }
                            }
                        }
                        
                        VStack{
                            NavigationLink(destination: WarehouseOrderItem(brand: "Stumptown", order: "stumptown")){
                                HStack{
                                    Text("Stumptown")
                                }
                            }
                        }
                        
                        VStack{
                            NavigationLink(destination: WarehouseOrderItem(brand: "Intelligentsia", order: "intelligentsia")){
                                HStack{
                                    Text("Intelligentsia")
                                }
                            }
                        }
                        
                        VStack{
                            NavigationLink(destination: WarehouseOrderItem(brand: "Carabou", order: "Carabou")){
                                HStack{
                                    Text("Carabou")
                                }
                            }
                        }
                        
                        VStack{
                            NavigationLink(destination: WarehouseOrderItem(brand: "Mighty Leaf", order: "Mighty Leaf")){
                                HStack{
                                    Text("Mighty Leaf")
                                }
                            }
                        }
                        
                        VStack{
                            NavigationLink(destination: WarehouseOrderItem(brand: "Other",order: "Other")){
                                HStack{
                                    Text("Other")
                                }
                            }
                        }
                        
                        
                    }.navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .principal) {
                            VStack {
                                Text("brands").font(.headline) .fixedSize(horizontal: true, vertical: false)
                            }
                        }
                    }
              //  }
            }
        }
        
        
    }
}
