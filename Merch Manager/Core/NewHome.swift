//
//  NewHome.swift
//  Merch Manager
//
//  Created by Gino Tateo on 9/2/22.
//

import SwiftUI

struct NewHome: View {
    @State var splashScreen  = true

    var body: some View {
         ZStack{
            Group{
              if splashScreen {
                  SplashScreen()
               }
              else{
                  MainView()
                    }
                }
               .onAppear {
                  DispatchQueue
                       .main
                       .asyncAfter(deadline:
                        .now() + 3) {
                   self.splashScreen = false
                  }
                }
            }
        }
    }



struct SplashScreen: View {
    var body: some View {
        ZStack{
            Color.white.edgesIgnoringSafeArea(.all)
            LottieView(filename: "coffeesplash")
                .offset(x: 0, y: -50)
        }
    }
}

struct MainView: View {
    
    @State var changeOffset  = false
    @State var changeOpacity  = false
    @EnvironmentObject var userStore: UserStore
    
    var body: some View {

            ZStack{
                
                if(userStore.currentUserInfo?.authenticated==true){
                userHome()
                } else{
                    
                Color.white.edgesIgnoringSafeArea(.all)
                
                LoginPart()
                
                ZStack{
                    ZStack{
                        Text("Merch Manager").font(.system(size: 50, weight: .bold , design: .rounded))
                            .multilineTextAlignment(TextAlignment.center)
                            .foregroundColor(.brown)
                            .frame(width: 350, height: 200)
                            .offset(x: 0, y: -100)
//                        Image("gkonp9")
//                            .font(.system(size: 70))
//                            .multilineTextAlignment(.leading)
//                            .frame(width: 350, height: 200)
//                            .offset(x: 0, y: -30)
                        
                    }
                    
//                    Rectangle()
//                        .foregroundColor(.white)
//                        .frame(width: 350, height: 100)
//                        .opacity(changeOpacity ? 0 : 1)
//                        .offset(x: 0, y: -100)
//                        .animation(Animation.easeInOut(duration: 3))
//                        .onAppear() {
//                            self.changeOpacity.toggle()
//                        }
                    
                }
                
                
                Image("gkonp9")
                    .resizable()
                    .font(.system(size: 70))
                    .frame(width: 125, height: 125)
                    .offset(x: 2, y: changeOffset ? -240 : 2)
                    .animation(Animation.easeInOut(duration: 1))
                    .onAppear() {
                        self.changeOffset.toggle()
                    }
                
            }
        }
    }
}


struct LoginPart: View {
    @State var changeOffset  = false
    @EnvironmentObject var userStore: UserStore
    
    var body: some View {
        
        
        
        ZStack{
           
            
           
            
            ZStack{
//                    Text("Good Morning")
//                        .font(.system(size: 35))
//                        .fontWeight(.semibold)
//                        .foregroundColor(Color.brown)
//                        .multilineTextAlignment(.leading)
//                        .frame(width: 350, height: 200)
//                        .offset(x: -5, y: -290)
//
//                    Text("Gino")
//                        .font(.system(size: 35))
//                        .fontWeight(.semibold)
//                        .foregroundColor(Color.white)
//                        .multilineTextAlignment(.leading)
//                        .frame(width: 350, height: 200)
//                        .offset(x: -5, y: -250)
                    
                    
                
//                Text("It's a Great Day for Coffee.")
//                    .font(.system(size: 35))
//                    .fontWeight(.semibold)
//                    .foregroundColor(Color.white)
//                    .multilineTextAlignment(.leading)
//                    .frame(width: 350, height: 200)
//                    .offset(x: -45, y: -290)
                   
                
                   
                
                
//                Text("Lorem ipsum dolor sit amet, adipiscing elit. Nullam pulvinar dolor sed enim eleifend efficitur.")
//                    .font(.title2)
//                    .fontWeight(.regular)
//                    .foregroundColor(Color.white.opacity(0.8))
//                    .multilineTextAlignment(.leading)
//                    .frame(width: 350, height: 200)
//                    .offset(x: 0, y: -170)
                
                
            }.padding()
            
            ButtonUI()
           
        } .offset(x: 0, y: changeOffset ?  400 : 700)
            .animation(Animation.easeInOut(duration: 1))
                        .onAppear() {
                            self.changeOffset.toggle()
          }
           
    }
}
///


struct ButtonUI: View {

    @State var showCreateAccount: Bool = false
    @State var showLogin: Bool = false
    var body: some View {

     
            
            ZStack{
                HStack{
                    Button("Create Account",action: {
                        withAnimation {
                        do {
                            print("Creating Account")
                            showCreateAccount.toggle()
                            }
                        catch {
                            print(error.localizedDescription)
                                }
                            }
                        }
                    ).font(.system(size: 20, weight: .light , design: .rounded))
                        .multilineTextAlignment(TextAlignment.center)
                        .foregroundColor(.brown)
                        .frame(width: 150, height: 50)
                        .overlay { RoundedRectangle(cornerRadius: 10.0)
                                .stroke(.brown, lineWidth: 2.0)
                        }.offset(x: 5, y: 0)
                        .sheet(isPresented: $showCreateAccount) { CreateAccountView()}
                    
                    Button("Login",action: {
                        withAnimation {
                        do {
                            print("Logging in")
                            showLogin.toggle()
                            }
                        catch {
                            print(error.localizedDescription)
                                }
                            }
                        }
                    ).font(.system(size: 20, weight: .light , design: .rounded))
                        .multilineTextAlignment(TextAlignment.center)
                        .foregroundColor(.brown)
                        .frame(width: 150, height: 50)
                        .overlay { RoundedRectangle(cornerRadius: 10.0)
                                .stroke(.brown, lineWidth: 2.0)
                        }.offset(x: 5, y: 0)
                        .sheet(isPresented: $showLogin) { Login()}

        
                }
                
            }.offset(x: 0, y: -30)
        
    }
}

struct userHome: View{
    @EnvironmentObject var userStore: UserStore
    @State var changeOffset  = false
    @State var changeOpacity  = false
    
    var body: some View{
            
            NavigationView{
                ZStack{
                    //Color.black.ignoresSafeArea()
//                    LinearGradient(
//                        colors: [.gray],
//                        startPoint: .topLeading,
//                        endPoint: .bottomTrailing
//                    )
//                    .ignoresSafeArea()
//                    .safeAreaInset(edge: .bottom, alignment: .center, spacing: 0) {
//                        Color.clear
//                            .frame(height: 45)
//                            .background(Material.bar)
//                    }
                    
//                    Image("drip") .resizable()
//                        .resizable()
//                        .aspectRatio(contentMode: .fill)
//                        .edgesIgnoringSafeArea(.all)
//                        .frame(maxWidth: UIScreen.main.bounds.width,
//                               maxHeight: UIScreen.main.bounds.height)


                    VStack{
                        Text("Merch Manager").font(.system(size: 50, weight: .bold , design: .rounded))
                            .multilineTextAlignment(TextAlignment.center)
                            .foregroundColor(.brown)
                        
                        Text("\(Date())").font(.system(size: 10, weight: .light , design: .rounded))
                            .multilineTextAlignment(TextAlignment.center)
                            .foregroundColor(.brown)
                        HStack{
                            Text("\(userStore.currentUserInfo?.firstName ?? "") \(userStore.currentUserInfo?.lastName ?? "")" ).font(.system(size: 15, weight: .light , design: .rounded))
                                .multilineTextAlignment(TextAlignment.center)
                                .foregroundColor(.brown)
                            
                            Text("#\(userStore.currentUserInfo?.routeNumber ?? "")").font(.system(size: 15, weight: .light , design: .rounded))
                                .multilineTextAlignment(TextAlignment.center)
                                .foregroundColor(.brown)
                        }
                        
                        Spacer()
                        
//                        // For debug
//                        Button("is rsr", action: {
//                            withAnimation {
//                                togglrsr()
//                            }
//                        }).font(.system(size: 20, weight: .light , design: .rounded))
//                            .multilineTextAlignment(TextAlignment.center)
//                            .foregroundColor(.brown)
//                            .frame(width: 150, height: 50)
//                            .overlay { RoundedRectangle(cornerRadius: 10.0)
//                                    .stroke(.white, lineWidth: 2.0)
//                            }
//

                        Image("gkonp9")
                        
                        Spacer()
                        
                        if((userStore.currentUserInfo?.IsRSR) == true){
                            
                            NavigationLink(destination: WarehouseOrderSheet()){
                                HStack{
                                    Spacer()
                                    Text("Order Sheet").font(.system(size: 20, weight: .light , design: .rounded))
                                        .multilineTextAlignment(TextAlignment.center)
                                        .foregroundColor(.brown)
                                        .frame(width: 150, height: 50)
                                        .overlay { RoundedRectangle(cornerRadius: 10.0)
                                                .stroke(.brown, lineWidth: 2.0)
                                        }
                                    Spacer()
                                }
                            }
                            
                            NavigationLink(destination: AccountView()){
                                HStack{
                                    Spacer()
                                    Text("Account").font(.system(size: 20, weight: .light , design: .rounded))
                                        .multilineTextAlignment(TextAlignment.center)
                                        .foregroundColor(.brown)
                                        .frame(width: 150, height: 50)
                                        .overlay { RoundedRectangle(cornerRadius: 10.0)
                                                .stroke(.brown, lineWidth: 2.0)
                                        }
                                    Spacer()
                                }
                            }
                            
                            
                        }else{
                            
                            
//                            GroupBox(
//                                label: Label("Next Stop", systemImage: "arrow.turn.down.right")
//                                    .foregroundColor(.red)
//                            ){
//                                Text("Your next stop is **Safeway 3132** on **5100 Broadway** in **Oakland**.").padding()
//
//                            }.padding()
//
//                            GroupBox(
//                                label: Label("Sales Recap", systemImage: "dollarsign.square")
//                                    .foregroundColor(.green)
//                            ) {
//                                Text("You have **$2180** in sales and **$100** in returns for a profit of **$2080**").padding()
//                            }.padding()
//
                            
                            NavigationLink(destination: Dashboard() ){
                                HStack{
                                    Spacer()
                                    Text("Dashboard").font(.system(size: 20, weight: .light , design: .rounded))
                                        .multilineTextAlignment(TextAlignment.center)
                                        .foregroundColor(.brown)
                                        .frame(width: 150, height: 50)
                                        .overlay { RoundedRectangle(cornerRadius: 10.0)
                                                .stroke(.brown, lineWidth: 2.0)
                                        }
                                    Spacer()
                                }
                            }
                            
                            NavigationLink(destination: Service()){
                                HStack{
                                    Spacer()
                                    Text("Stores").font(.system(size: 20, weight: .light , design: .rounded))
                                        .multilineTextAlignment(TextAlignment.center)
                                        .foregroundColor(.brown)
                                        .frame(width: 150, height: 50)
                                        .overlay { RoundedRectangle(cornerRadius: 10.0)
                                                .stroke(.brown, lineWidth: 2.0)
                                        }
                                    Spacer()
                                }
                            }
                            
                            NavigationLink(destination: PlanDay() ){
                                HStack{
                                    Spacer()
                                    Text("Plan Day").font(.system(size: 20, weight: .light , design: .rounded))
                                        .multilineTextAlignment(TextAlignment.center)
                                        .foregroundColor(.brown)
                                        .frame(width: 150, height: 50)
                                        .overlay { RoundedRectangle(cornerRadius: 10.0)
                                                .stroke(.brown, lineWidth: 2.0)
                                        }
                                    Spacer()
                                }
                            }
                            
                            NavigationLink(destination: ItemView() ){
                                HStack{
                                    Spacer()
                                    Text("Items").font(.system(size: 20, weight: .light , design: .rounded))
                                        .multilineTextAlignment(TextAlignment.center)
                                        .foregroundColor(.brown)
                                        .frame(width: 150, height: 50)
                                        .overlay { RoundedRectangle(cornerRadius: 10.0)
                                                .stroke(.brown, lineWidth: 2.0)
                                        }
                                    Spacer()
                                }
                            }
                            
                            
                            
                            NavigationLink(destination: AccountView() ){
                                HStack{
                                    Spacer()
                                    Text("Account").font(.system(size: 20, weight: .light , design: .rounded))
                                        .multilineTextAlignment(TextAlignment.center)
                                        .foregroundColor(.brown)
                                        .frame(width: 150, height: 50)
                                        .overlay { RoundedRectangle(cornerRadius: 10.0)
                                                .stroke(.brown, lineWidth: 2.0)
                                        }
                                    Spacer()
                                }
                            }
                        }
                        
                        Spacer()
                    }
//                    .navigationBarTitleDisplayMode(.inline)
//                    .toolbar {
//                        ToolbarItem(placement: .principal) {
//                            VStack {
//
//
//
//
//                            }
//                        }
//                    }
                    
                
            }
            
        }
            
    }
    
    private func togglrsr(){
        userStore.currentUserInfo?.IsRSR.toggle()
    }
    
}
