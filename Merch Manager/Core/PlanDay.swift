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
    
    var body: some View {
        VStack{
            List {
                ForEach(items) { item in
                    
                       HStack{
                           Text(String(item.plan))
                            Spacer()
                            Text(item.name!)
                            Text(String(item.number))
                            Spacer()
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
         .navigationBarItems(trailing: Button(action: {refactor.toggle() }, label: {
                            Image(systemName: "car")
        .imageScale(.large) }))
        .sheet(isPresented: $refactor) { CreatePlanView()}


    }
}

//struct PlanDay_Previews: PreviewProvider {
//    static var previews: some View {
//        PlanDay()
//    }
//}
//
