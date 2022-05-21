//
//  CreatePlanView.swift
//  Merch Manager
//
//  Created by Gino Tateo on 4/26/22.
//

import SwiftUI

struct CreatePlanView: View {
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Store.plan, ascending: true)])

    private var items: FetchedResults<Store>

    @ObservedObject var dateModelController = DateModelController()
    
    @Environment (\.presentationMode) var presentationMode
    
    var body: some View {

        VStack {
            Text("Please choose a delivery date.").font(.title).bold()
            ScrollView(.horizontal, showsIndicators: false, content: {
                HStack(spacing: 10) {
                    ForEach(dateModelController.listOfValidDates, id: \.self) { date in
                        GridView(date: date).onTapGesture {
                            
                            self.dateModelController.toggleIsSelected(date: date)
                            //presentationMode.wrappedValue.dismiss()
                        }
                        
                    }
                    
                }
                
            })
            Spacer()
            HStack {
                Text("Delivery overview: ")
                Text("\(self.dateModelController.selectedDate)").foregroundColor(.green).bold()
            }.padding(.top, 20)
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
        }.padding().padding(.top, 30)
        
    }

}
struct CreatePlanView_Previews: PreviewProvider {
    static var previews: some View {
        CreatePlanView()
    }
}
