//
//  WarehouseOrderItem.swift
//  Merch Manager
//
//  Created by Gino Tateo on 7/31/22.
//
//
//  ItemView.swift
//  Merch Manager
//
//  Created by Gino Tateo on 6/3/22.
//
//
import SwiftUI
import Foundation
import CoreData
import Firebase
import FirebaseFirestore
import MapKit

struct WarehouseOrderItem: View {
    @Environment(\.managedObjectContext) private var WarehouseOrderForm
    @EnvironmentObject var userStore: UserStore
    @ObservedObject var dateModelController = DateModelController()
    
    @State var size = 18
    
    
    @State var openAddItem = false
    @State var showOrderItem = false
    
    
    
    var brand: String
    
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Items.size, ascending: true)])
    private var items: FetchedResults<Items>
    
    //        @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Items.size, ascending: true)], predicate: NSPredicate(format: "Items.name = French Roast"))
    //        private var items: FetchedResults<Items>
    //
    //        @FetchRequest(
    //            sortDescriptors: [NSSortDescriptor(keyPath: \Items.size, ascending: true)],
    //            predicate: NSPredicate(format: "size > %@", 15)
    //        )
//    private var items: FetchedResults<Items>
//    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Order.date, ascending: true)])
//    private var orders: FetchedResults<Order>
//
    
    let db = Firestore.firestore()
    
    var order = ""
    //var book: Book
    //@EnvironmentObject var books: Book
    
    let formatter = NumberFormatter()
    //   let formatter.minimumFractionDigits = 0
    //    formatter.maximumFractionDigits = 2
    //    formatter.numberStyle = .decimal
    
    var body: some View {
        
        
        
        
        HStack(alignment: .top) {
            //Image(book.mediumCoverImageName)
            //                .resizable()
            //                .aspectRatio(contentMode: .fit)
            //                .frame(height: 90)
            VStack(alignment: .leading) {
                //                Text($book.title)
                //                    .font(.headline)
                //                Text("by \(book.author)")
                //                    .font(.subheadline)
                //                Text("\(book.pages) pages")
                //                    .font(.subheadline)
            }
            Spacer()
        }
        
        
        List {
            ForEach(items) { item in
                
                
                HStack{
                    
                    //Text(order.head)
                    Text(item.name!).frame(alignment: .leading).font(.headline)
                    Spacer()
                    Text(item.type!).frame(alignment: .leading)
                        .sheet(isPresented: $showOrderItem) { WarehouseOrderItem2()}
                    Spacer()
                    Text(formatter.string(for: item.size) ?? "n/a").frame(alignment: .leading).font(.callout)
                    
                }.swipeActions(allowsFullSwipe: false) {
                    Button {
                        print("1")
                        addItem(item: item, quantity: 1)
                    } label: {
                        Label("1", systemImage: "1.circle")
                    }
                    .tint(.blue)
                    
                    Button {
                        print("3")
                        addItem(item: item, quantity: 3)
                    } label: {
                        Label("3", systemImage: "3.circle")
                    }
                    
                    Button {
                        print("5")
                        addItem(item: item, quantity: 5)
                    } label: {
                        Label("5", systemImage: "5.circle")
                    }
                    
                    
                }
                
            }
        }.navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text(brand).font(.headline) .fixedSize(horizontal: true, vertical: false)
                    }
                }
            }
    }
        //import SwiftUI
        //    }
        //}
        
        //    private func deleteItems(offsets: IndexSet) {
        //        withAnimation {
        //            offsets.map { items[$0] }.forEach(WarehouseOrderForm.delete)
        //
        //
        //
        //            do {
        //                try WarehouseOrderForm.save()
        //            } catch {
        //                // Replace this implementation with code to handle the error appropriately.
        //                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        //                let nsError = error as NSError
        //                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        //            }
        //        }
        //    }
        //
        func addItem(item: Items, quantity: Int) {
            withAnimation {
                openAddItem = true
                db.collection("Warehouse/").document("0")
                    .collection("\(userStore.currentUserInfo?.routeNumber ?? "0")").document(self.dateModelController.selectedDateFormatted)
                    .collection("order").addDocument(data: ["item" : item.name, "size" : item.size, "quantity": quantity])
                
            }
        }
        //
        //    private func addToOrder(){
        //
        //    }
        //}
        
    
}
//struct BooksListView: View {
//  @StateObject var viewModel = BooksViewModel()
//  var body: some View {
//    List(viewModel.books) { book in
//      Text("\(book.title) by \(book.author)")
//    }
//  }
//}
