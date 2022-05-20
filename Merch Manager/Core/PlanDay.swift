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
    
    @EnvironmentObject var PlanDayData: PlanDayData
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
         .sheet(isPresented: $refactor) { CreatePlanView()}
         .toolbar {
            ToolbarItem(placement: .principal) {
                VStack {
                    Text("My Day").font(.headline) .fixedSize(horizontal: true, vertical: false)
                    Text("Plan day").font(.subheadline)
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                                EditButton()
                            }
        }
        .navigationBarItems(trailing: Button(action: { }, label: {
                            Image(systemName: "car")
            .imageScale(.large) }))


    }
}

//struct PlanDay_Previews: PreviewProvider {
//    static var previews: some View {
//        PlanDay()
//    }
//}
//
