//
//  StoreView.swift
//  Merch Manager
//
//  Created by Gino Tateo on 4/16/22.
//

import SwiftUI
import CoreData
import MapKit



struct StoreView: View {
    
    @EnvironmentObject var Locationstore: LocationStore
    var item: Store
    

//    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: CLLocationManager().location?.coordinate.longitude ?? 0 , longitude: CLLocationManager().location?.coordinate.longitude  ?? 0), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
//
    
    
    var body: some View {

        VStack{
            
            //Map(coordinateRegion: $mapRegion)
            
                Form{
                    Section(header: Text("Store")){
                        List{
                            HStack{
                            Text(item.name!)
                            Text(String(item.number))
                            }
                            Text(item.city!)
//                            Text("RSR Route #"+item.rsrnum!)
//                            Text("Merch Route #"+item.merchnum!)

                        }
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                  ToolbarItem(placement: .principal) {
                      VStack {
                          Text(item.name!).font(.headline)
                          Text("Store View").font(.subheadline)
                      }
                  }

          }
            
        }
    }
}

//struct StoreView_Previews: PreviewProvider {
//    static var previews: some View {
//        StoreView(store)
//    }
//}
