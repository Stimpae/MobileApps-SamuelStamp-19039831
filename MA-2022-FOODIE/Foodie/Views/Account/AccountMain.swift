//
//  AccountMain.swift
//  Foodie
//
//  Created by Samuel Stamp on 23/05/2022.
//

import SwiftUI


struct AccountMain: View {
    
    @EnvironmentObject var userData : UserData
    
    @State private var action: Action?
    
    @State var width = UIScreen.main.bounds.width
    @State var height = UIScreen.main.bounds.height
    
    var body: some View {
        ZStack{
            CustomColor.background.ignoresSafeArea()
            
            NavigationView{
                VStack{
                    
                    Spacer()
                    
                    Image("FoodieLogoV3")
                        .resizable()
                        .clipped()
                        .frame(width: width / 2.1, height: width / 2.3)
                    
                    Text("FOODIE")
                        .font(.custom("Garet-Heavy", size: 36))
                        .padding(.top, -30.0)
                    
                    Text("...")
                        .font(.custom("Garet-Heavy", size: 36))
                        .padding(.top, -60.0)
                    
                    Spacer()
                
        
                    NavigationLink("LOGIN", destination: AccountLogin())
                        .foregroundColor(Color.white)
                        .font(Font.custom("Garet-Heavy", size: 15))
                        .frame(width: width - 42, height: 50, alignment: .center)
                        .background(CustomColor.orange)
                        .cornerRadius(12)
                        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 4)
                        .navigationBarTitle("")
                        .navigationBarHidden(true)
                    
                    Text("OR")
                        .font(Font.custom("Inter-Bold", size: 14))
                    
                    Button(action: {
                        
                        action = .register
                        
                    }, label: {Text("REGISTER")})
                        .foregroundColor(Color.black
                        )
                        .font(Font.custom("Garet-Heavy", size: 15))
                        .frame(width: width - 42, height: 50, alignment: .center)
                        .background(CustomColor.yellow)
                        .cornerRadius(12)
                        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 4)
                    
                    Spacer()
                    
                }
            }
            
        }
        .sheet(item: $action) {item in
            switch item {
            case .register:
                AccountRegister()
            case .resetpw:
                AccountRegister()
            }
        }
    }
}

struct AccountMain_Previews: PreviewProvider {
    static var previews: some View {
        AccountMain()
    }
}
