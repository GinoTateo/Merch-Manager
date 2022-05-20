//
//  StartRouteView.swift
//  Merch Manager
//
//  Created by Gino Tateo on 12/15/21.
//

import SwiftUI
import CoreData
import Firebase
import MapKit



struct Dashboard: View {
    
    @Environment(\.managedObjectContext) private var Dashboard
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Store.dos, ascending: true)])
    private var items: FetchedResults<Store>
    
    var sales = 1200
    var miles = 56
    

    
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.83500, longitude: -122.24871), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    
    
  
    @EnvironmentObject var userStore: UserStore
    var body: some View {
        
        
            VStack{

                    Map(coordinateRegion: $mapRegion)

//            LinearGradient(
//                colors: [.mint, .teal, .cyan, .indigo],
//                startPoint: .topLeading,
//                endPoint: .bottomTrailing
//            )
//            .ignoresSafeArea()
//            .navigationTitle(userStore.currentUserInfo!.dow)
//            .safeAreaInset(edge: .bottom, alignment: .center, spacing: 0) {
//                Color.clear
//                    .frame(height: 20)
//                    .background(Material.bar)
//            }
                
                    
                
                
                List {
                    ForEach(items.prefix(5)) { item in
                        NavigationLink(destination: OrderSheet(dow: userStore.currentUserInfo!.dow,item: item)){
                            HStack{
                                Spacer()
                                Text(item.name!)
                                Text(String(item.number))
                                Spacer()
                            }
                        }
                            .swipeActions(allowsFullSwipe: false) {
                                    Button {
                                            print("Skipping")
                                    } label: {
                                            Label("Skip", systemImage: "chevron.right.2")
                                    }
                                        .tint(.blue)

                                    Button(role: .destructive) {
                                            print("Deleting conversation")
                                    } label: {
                                            Label("Delete", systemImage: "trash.fill")
                                            }
                                        }
                    
                    }
                }
                
                
                
                
            }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                VStack {
                    Text("My \(userStore.currentUserInfo!.dow)").font(.headline) .fixedSize(horizontal: true, vertical: false)
                    Text("Dashboard").font(.subheadline)
                }
            }
        }
        
       


        VStack{
            
           

            Spacer()
            
                HStack{
                    Button("Sales", action: {
                        withAnimation {
    
                        }
                    })
                        .padding()
                        .frame(height: 45)
                        .background(Color.green)
                        .cornerRadius(15)
                    
                    Button("Miles", action: {
                        withAnimation {
                            
                        }
                    })

                    .padding()
                    .frame(height: 45)
                    .background(Color.green)
                    .cornerRadius(15)
                }
        }
    }


    
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(Dashboard.delete)

            do {
                try Dashboard.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    
}

