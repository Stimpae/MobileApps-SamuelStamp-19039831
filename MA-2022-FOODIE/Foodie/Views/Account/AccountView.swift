//
//  AccountView.swift
//  Foodie
//
//  Created by Samuel Stamp on 24/05/2022.
//

import SwiftUI

struct AccountView: View {
    
    @State var width = UIScreen.main.bounds.width
    @State var height = UIScreen.main.bounds.height
    
    @State private var action: Action?
    
    @EnvironmentObject var userData : UserData
    
    @State var preferencesManager: PreferencesManager = PreferencesManager()
    
    @State private var showingSheet = false
    
    var body: some View {
        ZStack{
            
            CustomColor.background.ignoresSafeArea()
            
            RoundedRectangle(cornerRadius: 22)
                .fill(CustomColor.blue)
                .padding(21.0)
                .frame(width: self.width)
                .offset(y: -self.width - 50)
                .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 4)
            
            VStack{
                
                Spacer()
                
                VStack{
                    
                    HStack
                    {
                        VStack
                        {
                            Text("Account")
                                .font(.custom("Garet-Heavy", size: 30))
                                .foregroundColor(CustomColor.background)
                                .multilineTextAlignment(.leading)
                                .frame(width: width / 2, alignment: .leading)
                            
                            Text("Welcome back \(userData.user.name)")
                                .font(.custom("Inter-Regular", size: 17))
                                .foregroundColor(CustomColor.yellow)
                                .multilineTextAlignment(.leading)
                                .frame(width: width / 2, alignment: .leading)
                        }
                        .padding()
                        
                        Spacer()
                    }
                    
                    Button(action: {
                        
                        showingSheet.toggle()
                        
                    }, label: {Text("PREFERENCES")})
                        .foregroundColor(Color.black
                        )
                        .font(Font.custom("Garet-Heavy", size: 15))
                        .frame(width: width - 62, height: 50)
                        .background(CustomColor.yellow)
                        .cornerRadius(12)
                        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 4)
                    
                    
                    
                    Button(action: {
                        
                        FBAuth.logout { (result) in
                            print("Logged Out")
                        }

                    }) {Text("LOG OUT")
                        
                        .foregroundColor(Color.white)
                        .font(Font.custom("Garet-Heavy", size: 15))
                        .frame(width: width - 62, height: 50, alignment: .center)
                        .background(CustomColor.orange)
                        .cornerRadius(12)
                        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 4)
                    }
                    
                    Spacer()
                }
                .padding(.horizontal)
            }
        }
        .ignoresSafeArea(.keyboard)
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .sheet(isPresented: $showingSheet)
        {
            AccountPreferences(Preferences: preferencesManager)
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
