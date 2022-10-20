//
//  PlanDay.swift
//  Merch Manager
//
//  Created by Gino Tateo on 12/15/21.
//

import SwiftUI
import CoreData
import Firebase
import Foundation
import FirebaseFirestore



struct PlanDay: View {
    
    @Environment(\.managedObjectContext) private var PlanDay
    @EnvironmentObject var userStore: UserStore

    //@EnvironmentObject var routeData: RouteData


    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Store.plan, ascending: true)])

    private var items: FetchedResults<Store>
    @State var refactor: Bool = false
    @State var counter: Int16 = 1
    
    var body: some View {
        VStack{
            List {
                ForEach(items) { item in
                    
                       HStack{
                           if(item.plan > 0){
                               Text(String(item.plan))
                           }
                            Spacer()
                            Text(item.name!)
                            Text(String(item.number))
                            Spacer()
                       }.swipeActions(allowsFullSwipe: false) {
                           Button {
                               print(counter)
                               
                               item.plan = counter
                               if counter > userStore.currentUserInfo?.numStores ?? 20{
                                   counter = 1
                               }
                               else{
                                   counter+=1
                               }
                               
                               
                               
                           } label: {
                               Label("+", systemImage: "plus")
                           }
                           .tint(.blue)
                       }
                }
            }
        }.navigationBarTitleDisplayMode(.inline)
         .toolbar {
            ToolbarItem(placement: .principal) {
                VStack {
                    Text("My Plan").font(.headline)
                }
            }
        }
         .navigationBarItems(trailing: Button(action: {resetOrder() }, label: {
                            Image(systemName: "tray.2.fill")
        .imageScale(.large) }))
        .sheet(isPresented: $refactor) { CreatePlanView()}


    }
    
    func resetOrder(){
        for item in items{
            item.plan = 0
        }
        counter = 1;
    }
}

//struct PlanDay_Previews: PreviewProvider {
//    static var previews: some View {
//        PlanDay()
//    }
//}
//
