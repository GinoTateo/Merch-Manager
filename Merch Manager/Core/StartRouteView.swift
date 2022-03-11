//
//  StartRouteView.swift
//  Merch Manager
//
//  Created by Gino Tateo on 12/15/21.
//

import SwiftUI

struct StartRouteView: View {
    var body: some View {
        NavigationView {
            ZStack{
            LinearGradient(
                colors: [.mint, .teal, .cyan, .indigo],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            .navigationTitle("Hello World")
            .safeAreaInset(edge: .bottom, alignment: .center, spacing: 0) {
                Color.clear
                    .frame(height: 20)
                    .background(Material.bar)
            }
            
                Text("Hello")
            }
        }
    }


    
    
    private func start(){
        
    }
}

struct StartRouteView_Previews: PreviewProvider {
    static var previews: some View {
        StartRouteView()
    }
}
