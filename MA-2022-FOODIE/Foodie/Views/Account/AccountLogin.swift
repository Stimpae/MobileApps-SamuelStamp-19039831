//
//  AccountLogin.swift
//  Foodie
//
//  Created by Samuel Stamp on 23/05/2022.
//

import SwiftUI

enum Action : Identifiable{
    case register, resetpw
    var id: Int {
        hashValue
    }
}

struct AccountLogin: View {
    
   
    @State private var action: Action?
    
    @EnvironmentObject var userData : UserData
    @State var user: UserViewModel = UserViewModel()
    
    @State var width = UIScreen.main.bounds.width
    @State var height = UIScreen.main.bounds.height

    @State private var showPassword: Bool = false
    
    @State private var showAlert : Bool = false
    @State private var authError: EmailAuthError?
    
    var body: some View {
        
        ZStack{
            
            CustomColor.background.ignoresSafeArea()
            
            RoundedRectangle(cornerRadius: 22)
                .fill(CustomColor.blue)
                .padding(21.0)
                .frame(width: self.width)
                .offset(y: -self.width + 50)
                .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 4)
            
            VStack{
                
                VStack{
                    
                    Spacer()
                    
                    HStack
                    {
                        VStack
                        {
                            Text("Welcome Back.")
                                .font(.custom("Garet-Heavy", size: 36))
                                .foregroundColor(CustomColor.background)
                                .multilineTextAlignment(.leading)
                                .frame(width: width / 2, alignment: .leading)
                            
                            Text("Sign in to continue.")
                                .font(.custom("Inter-Regular", size: 17))
                                .foregroundColor(CustomColor.yellow)
                                .multilineTextAlignment(.leading)
                                .frame(width: width / 2, alignment: .leading)
                        }
                        .padding()
                        
                        Spacer()
                    }
                    
                    Spacer()
                    
                    VStack{
                        
                        InputFieldView(inputText: "Email Address", inputImage: "envelope", returnText: $user.email)
                        InputProtectedFieldView(inputText: "Password", inputImage: "lock", returnText: $user.password)
                        
                        HStack{
                            
                            Spacer()

                            Button(action: {
                                
                                action = .resetpw
                                
                                // MARK: - Show sheet view of the forgotten password stuff (need to make the page)
                                
                            }, label: {Text("Forgotten Password")})
                                .foregroundColor(.white)
                                .font(.custom("Inter-Regular", size: 13))
                                .padding(.horizontal)
                        }
                    }
                    .padding()
                }
                .padding(.horizontal)
                
                VStack{
                    
                    Spacer()
                    
                    Button(action: {
                        
                        FBAuth.authenticate(withEmail: self.user.email , password: self.user.password) {  (result) in
                            switch result {
                            case .failure(let error):
                                self.authError = error
                                self.showAlert = true
                            case .success( _):
                                print("Signed in")
                            }
                        }

                    }) {Text("LOGIN")
                        
                        .foregroundColor(Color.white)
                        .font(Font.custom("Garet-Heavy", size: 15))
                        .frame(width: width - 42, height: 50, alignment: .center)
                        .background(CustomColor.orange)
                        .cornerRadius(12)
                        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 4)
                    }
                    .disabled(!user.isLogInComplete)
                    .opacity(user.isLogInComplete ? 1 : 0.5)
                    
            
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
        .alert(isPresented: $showAlert)
        {
            Alert(title: Text("Login Error"), message: Text(self.authError?.localizedDescription ?? "Unkown Error"), dismissButton: .default(Text("OK")){
                if self.authError == .incorrectPassword{
                    self.user.password = ""
                } else{
                    self.user.password = ""
                    self.user.email = ""
                }
            })
        }
        .ignoresSafeArea(.keyboard)
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .sheet(item: $action) {item in
            switch item {
            case .register:
                AccountRegister()
            case .resetpw:
                ForgotPasswordView()
            }
            
        }
    }
}

struct AccountLogin_Previews: PreviewProvider {
    static var previews: some View {
        AccountLogin()
    }
}
