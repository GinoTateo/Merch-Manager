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
    @State var viewStoreService = false
    
    @Environment(\.managedObjectContext) private var ConentView

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Store.name, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Store>

    
    var body: some View {
        VStack{
        NavigationView{
            VStack(){
            List {
                VStack(spacing: 1){
                    Button(action: beginDay) {
                        Text("Begin Day").bold()
                    } .sheet(isPresented: $showBeginSheet) { BeginOfDay(showBeginSheet: self.$showBeginSheet) }
                    NavigationLink(destination: Service(dow: GetWeekday())){
                            
                        }
                    }
                VStack{
                    Button(action: beginDay) {
                        Text("Begin Day").bold()
                    } .sheet(isPresented: $showBeginSheet) { BeginOfDay(showBeginSheet: self.$showBeginSheet) }
                    NavigationLink(destination: Service(dow: GetWeekday())){
                            
                        }
                    }
  
    
            }    .navigationTitle("My \(GetWeekday()).")
                .navigationBarItems(trailing: Button(action: {
                    print("Open order sheet")
                    showOrderSheet = true
                }, label: {
                    Image(systemName: "plus.circle")
                        .imageScale(.large)
                }))
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

}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
