//
//  StartRouteView.swift
//  Merch Manager
//
//  Created by Gino Tateo on 12/15/21.
//

import SwiftUI
import CoreData
import Firebase
import FirebaseFirestore
import MapKit



struct Dashboard: View {
    
    @Environment(\.managedObjectContext) private var Dashboard
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Store.dos, ascending: true)])
    private var items: FetchedResults<Store>
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.83500, longitude: -122.24871), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))

    @EnvironmentObject var userStore: UserStore
    @EnvironmentObject var userDay: UserDay
    @ObservedObject var dateModelController = DateModelController()
    let db = Firestore.firestore()
    
    var body: some View {
        
        
            VStack{

                    Map(coordinateRegion: $mapRegion)
                
                
                List {
                    ForEach(items.prefix(5)) { item in
                        NavigationLink(destination: OrderSheet(item: item)){
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
                
                

        
       
        Spacer()

            
           
            if((userDay.currentDay?.beginDay) == false){
                HStack{
                    Button("Begin Route", action: {
                        withAnimation {
                            BeginDay()
                        }
                    })
                        .padding()
                        .frame(height: 45)
                        .font(.headline)
                        .background(Color.accentColor)
                        .foregroundColor(Color.white)
                        .cornerRadius(15)
                    
                }
            }else{
                Button("Complete Route", action: {
                    withAnimation {
                        BeginDay()
                    }
                })
                    .padding()
                    .frame(height: 45)
                    .font(.headline)
                    .background(Color.accentColor)
                    .foregroundColor(Color.white)
                    .cornerRadius(15)
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
        
    }



    func BeginDay(){
        print("Begin Day")
        let loggedDay = DayData.init(beginDay: true, startTime: Date(), currStore: 0)
        userDay.currentDay = loggedDay
        
        
    let routeRef = db
        .collection("User").document(Auth.auth().currentUser?.uid ?? "")
        .collection("LogCollection").document(self.dateModelController.selectedDateFormatted).setData(
            
            
            
            // Need a way of adding data from list to list

                                [
                                    "Begin Day": userDay.currentDay?.beginDay,
                                    "Start Time": userDay.currentDay?.startTime,
                                ]


            ) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print(self.dateModelController.selectedDateFormatted)
                }
            }
        
    }
    
    func CompleteDay(){
        print("Complete Day")
        
        
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

