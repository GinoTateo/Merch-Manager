//
//  ContentView.swift
//  Merch Manager
//
//  Created by Gino Tateo on 11/5/21.
//

import SwiftUI
import CoreData
import Firebase

struct Home: View {
    
    //User
    @EnvironmentObject var userStore: UserStore
    //@EnvironmentObject var Dow: dow

    
    @State var showOrderSheet = false
    @State var viewStoreService = true
    @State private var showAlert = false
    //@State var dow = ""
    
    @Environment(\.managedObjectContext) private var ConentView

    
    var body: some View {
        NavigationView{
            
            ZStack{
            LinearGradient(
                colors: [.gray],
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
                if(userStore.currentUserInfo?.authenticated==true){
                    
                    NavigationLink(destination: Dashboard() ){
                        HStack{
                            Spacer()
                            Text("Dashboard").multilineTextAlignment(TextAlignment.center)
                                .font(.system(size: 30, weight: .semibold , design: .rounded))
                                .foregroundColor(.black)
                            Spacer()
                        }
                    }
                    
                    GroupBox(
                        label: Label("Next Stop", systemImage: "arrow.turn.down.right")
                                    .foregroundColor(.red)
                                    ){
                                        Text("Your next stop is **Safeway 3132** on **5100 Broadway** in **Oakland**.").padding()
                                        
                                    }.padding()
                    
                    NavigationLink(destination: Service(dow: GetWeekday())){
                        HStack{
                            Spacer()
                            Text("Sales").multilineTextAlignment(TextAlignment.center)
                                .font(.system(size: 30, weight: .semibold , design: .rounded))
                                .foregroundColor(.black)
                            Spacer()
                        }
                    }
                    
                    GroupBox(
                        label: Label("Sales Recap", systemImage: "dollarsign.square")
                                    .foregroundColor(.green)
                                    ) {
                                        Text("You have **$2180** in sales and **$100** in returns for a profit of **$2080**").padding()
                                    }.padding()
                    
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
                }else{
                    Image("z0uy2c")
                    Image("gkonp9")
                }
               
                    Spacer()
                
                    HStack{
                        Spacer()
                        
                        if(userStore.currentUserInfo?.authenticated==true){
                            Button("Logout", action: {
                                withAnimation {
                                    logout()
                                }
                            })
                                    .font(.system(size: 30, weight: .semibold , design: .rounded))
                                    .foregroundColor(.black)
                                    .multilineTextAlignment(TextAlignment.center)
                            }
                        
                        else{
                            NavigationLink(destination: Login()){
                                Text("Login").multilineTextAlignment(TextAlignment.center)
                                    .font(.system(size: 30, weight: .semibold , design: .rounded))
                                    .foregroundColor(.black)
                                    .multilineTextAlignment(TextAlignment.center)
                            }
                        }
                        Spacer()
                    }
                }.multilineTextAlignment(TextAlignment.center)
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
    
    
    
    func logout(){
        
        let loggedUser = UserInfo.init(userName: "", email: "", routeNumber: "", authenticated: false,dow: GetWeekday(),firstName: "",lastName: "",postion: "")
        userStore.currentUserInfo = loggedUser
        
        
        let firebaseAuth = Auth.auth()
    do {
      try firebaseAuth.signOut()
    } catch let signOutError as NSError {
      print("Error signing out: %@", signOutError)
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
        
        let Today = weekdays[index-1]
        return weekdays[index-1] // Returns week day in String
        }
    }

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
