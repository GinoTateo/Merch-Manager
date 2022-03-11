//
//  ContentView.swift
//  Merch Manager
//
//  Created by Gino Tateo on 11/5/21.
//

import SwiftUI
import CoreData

struct Home: View {
    
    //User
    @EnvironmentObject var userStore: UserStore


    
    @State var showOrderSheet = false
    @State var viewStoreService = true
    @State private var showAlert = false
    
    @Environment(\.managedObjectContext) private var ConentView

    
    var body: some View {
        NavigationView{
            
            ZStack{
            LinearGradient(
                colors: [.mint, .teal, .cyan, .indigo],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            .safeAreaInset(edge: .bottom, alignment: .center, spacing: 0) {
                Color.clear
                    .frame(height: 45)
                    .background(Material.bar)
            }
            
            
            VStack{
                
                Spacer()
                
                    NavigationLink(destination: StartRouteView() ){
                        HStack{
                            Spacer()
                            Text("Start Route").multilineTextAlignment(TextAlignment.center)
                                .font(.system(size: 30, weight: .semibold , design: .rounded))
                                .foregroundColor(.black)
                                .multilineTextAlignment(TextAlignment.center)
                            Spacer()
                        }
                    }
                    
                Spacer()
                
                    NavigationLink(destination: Service(dow: GetWeekday())){
                        HStack{
                            Spacer()
                            Text("View Stores").multilineTextAlignment(TextAlignment.center)
                                .font(.system(size: 30, weight: .semibold , design: .rounded))
                                .foregroundColor(.black)
                                .multilineTextAlignment(TextAlignment.center)
                            Spacer()
                        }
                    }
                
                
                    
                    NavigationLink(destination: PlanDay(dow: GetWeekday()) ){
                        HStack{
                            Spacer()
                            Text("Plan Day").multilineTextAlignment(TextAlignment.center)
                                .font(.system(size: 30, weight: .semibold , design: .rounded))
                                .foregroundColor(.black)
                                .multilineTextAlignment(TextAlignment.center)
                            Spacer()
                        }
                    }
                
                
                                        
                    NavigationLink(destination: AccountView(dow: GetWeekday()) ){
                        HStack{
                            Spacer()
                            Text("Account").multilineTextAlignment(TextAlignment.center)
                                .font(.system(size: 30, weight: .semibold , design: .rounded))
                                .foregroundColor(.black)
                                .multilineTextAlignment(TextAlignment.center)
                            Spacer()
                        }
                    }
                
               
                    Spacer()
                
                    HStack{
                        Spacer()
                        
                        if(userStore.currentUserInfo?.authenticated==true){
                            NavigationLink(destination: AccountView()){
                                Text("Logout")
                                    .font(.system(size: 30, weight: .semibold , design: .rounded))
                                    .foregroundColor(.mint)
                                    .multilineTextAlignment(TextAlignment.center)
                            }
                        }
                        else{
                            NavigationLink(destination: Login()){
                                Text("Login").multilineTextAlignment(TextAlignment.center)
                                    .font(.system(size: 30, weight: .semibold , design: .rounded))
                                    .foregroundColor(.mint)
                                    .multilineTextAlignment(TextAlignment.center)
                            }
                        }
                        Spacer()
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

    }

