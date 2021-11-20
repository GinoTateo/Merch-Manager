//
//  StoreView.swift
//  Merch Manager
//
//  Created by Gino Tateo on 11/12/21.
//

import Foundation
import SwiftUI



struct StoreView: View {
    var stores = loadCSV(from: "storesCSV" )
    var body: some View {
        List(stores){ store in
            
            Text(store.chainName)
            
        }
    }
}

struct StoreView_Previews: PreviewProvider{
    static var previews: some View{
        StoreView()
    }
}
