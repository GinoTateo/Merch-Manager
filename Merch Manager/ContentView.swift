//
//  ContentView.swift
//  Merch Manager
//
//  Created by Gino Tateo on 11/5/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State var showOrderSheet = false
    @State var showBeginSheet = true
    @State var viewStoreService = true
    @State private var showAlert = false
    
    @Environment(\.managedObjectContext) private var ConentView

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Store.name, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Store>

    
    var body: some View {
        NavigationView{
            VStack{
                List{
                    Button(action: beginDay){
                        HStack{
                            Spacer()
                        if(showBeginSheet==true){
                            Text("Login")
                        }
                        else{
                            Text("Logout")
                        }
                            Spacer()
                        }
                    }.sheet(isPresented: $showBeginSheet) { BeginOfDay(showBeginSheet: self.$showBeginSheet)}
                    
                    NavigationLink(destination: Service(dow: GetWeekday())){
                        HStack{
                            Spacer()
                            Text("View store list")
                            Spacer()
                        }
                    }
                    
                    NavigationLink(destination: OrderSheet(dow: GetWeekday())){
                        HStack{
                            Spacer()
                            Text("Order")
                            Spacer()
                        }
                    }
                    
                }
            }
                .navigationBarTitleDisplayMode(.inline)
                .toolbar { // <2>
                    ToolbarItem(placement: .principal) { // <3>
                        VStack {
                            Text("My \(GetWeekday())").font(.headline)
                            Text("Home").font(.subheadline)
                        }
                    }
                }
            }
        }
    
    private func GetWeekday() -> String{
        let index = Foundation.Calendar.current.component(.weekday, from: Date()) // this returns an Int

        let weekdays = [ // Week days 0-6
            "Sunday",
            "Monday",
            "Tuesday",
            "Wednesday",
            "Thursday",
            "Friday",
            "Saturday"
        ]
        
        return weekdays[index-1] // Returns week day in String
        }
    
    private func storeListByDay() {
        let index = Foundation.Calendar.current.component(.weekday, from: Date()) // this returns an Int
    
        
    }
    
    
    private func beginDay(){
        print("Running Begin of Day")
        //showBeginSheet = true
    }



    private func viewStoreList(){
        print("View list")
        //showBeginSheet = true
    }
    
    
    private func logout(){
        print("User log out")
        showBeginSheet = true
        
    }

}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
