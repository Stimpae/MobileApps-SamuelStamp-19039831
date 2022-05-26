//
//  AccountRegister.swift
//  Foodie
//
//  Created by Samuel Stamp on 23/05/2022.
//

import SwiftUI

struct AccountRegister: View {
    
    @State var width = UIScreen.main.bounds.width
    @State var height = UIScreen.main.bounds.height
    
    @EnvironmentObject var userData : UserData
    @State var user: UserViewModel = UserViewModel()
    
    @Environment(\.dismiss) var dismiss
    
    @State private var showError = false
    @State private var errorString = ""
    
    @State private var showPassword: Bool = false
    
    var body: some View {
        ZStack{
            
            CustomColor.background.ignoresSafeArea()
        
            VStack{
                
                Spacer()
            
                VStack{
                    
                    Spacer()
                
                    HStack
                    {
                        VStack
                        {
                            Text("Register Account.")
                                .font(.custom("Garet-Heavy", size: 36))
                                .foregroundColor(CustomColor.blue)
                                .multilineTextAlignment(.leading)
                                .frame(width: width / 2, height: 110, alignment: .leading)
                            
                            Text("Sign up to continue.")
                                .font(.custom("Inter-Regular", size: 17))
                                .foregroundColor(CustomColor.orange)
                                .multilineTextAlignment(.leading)
                                .frame(width: width / 2, alignment: .leading)
                                .offset(y: -10)
                        }
                        .padding()
                        
                        Spacer()
                    }
                    
                    
                    VStack{
                        
                        VStack(alignment: .leading){
                        InputFieldView(inputText: "Full Name", inputImage: "person", returnText: $user.fullname)
                            if !user.validNameText.isEmpty{
                                Text(user.validNameText)
                                    .font(.custom("Inter-Regular", size: 11))
                                    .foregroundColor(.red)
                                    .multilineTextAlignment(.leading)
                            }
                        }
                        
                        // text
                        VStack(alignment: .leading){
                        InputFieldView(inputText: "Email Address", inputImage: "envelope", returnText: $user.email)
                            if !user.validEmailText.isEmpty{
                                Text(user.validEmailText)
                                    .font(.custom("Inter-Regular", size: 11))
                                    .foregroundColor(.red)
                                    .multilineTextAlignment(.leading)
                            }
                        }
                        // text
                        
                        VStack(alignment: .leading){
                        InputProtectedFieldView(inputText: "Password", inputImage: "lock", returnText: $user.password)
                            if !user.validPasswordText.isEmpty{
                                Text(user.validPasswordText)
                                    .font(.custom("Inter-Regular", size: 11))
                                    .foregroundColor(.red)
                                    .frame(height: 30)
                    
                            }
                        }
                        // text
                        
                        VStack(alignment: .leading){
                        InputProtectedFieldView(inputText: "Confirm Password", inputImage: "lock", returnText: $user.confirmedPassword)
                            if !user.validConfirmPassword.isEmpty{
                                Text(user.validConfirmPassword)
                                    .font(.custom("Inter-Regular", size: 11))
                                    .foregroundColor(.red)
                                    .multilineTextAlignment(.leading)
                            }
                        }
                        // text
                        
                    }
                    .padding()
        
                }
                .padding(.horizontal)
                
                VStack{
                    
                    Spacer()
                    
                    Button(action: {
                    
                        FBAuth.createUser(withEmail: self.user.email, name: self.user.fullname, password: self.user.password, firstTime: "yes"){
                            (result) in
                            switch result{
                            case .failure(let error):
                                self.errorString = error.localizedDescription
                                self.showError = true
                            case .success( _):
                                print("Account Creation Success")
                            }
                        }
                    }) {Text("SIGN UP")
                        
                        .foregroundColor(Color.white)
                        .font(Font.custom("Garet-Heavy", size: 15))
                        .frame(width: width - 42, height: 50, alignment: .center)
                        .background(CustomColor.orange)
                        .cornerRadius(12)
                        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 4)
                    }
                    .disabled(!user.isSignInComplete)
                    .opacity(user.isSignInComplete ? 1 : 0.5)
                    
                    Spacer()
                    
                    Button(action:{
                        dismiss()
                    }) {Text("Cancel")
                            .foregroundColor(CustomColor.blue)
                            .font(Font.custom("Inter-Medium", size: 16))
                    }
                
                }
            }
        }
        .alert(isPresented: $showError)
        {
            Alert(title: Text("Error Creating account"), message: Text(self.errorString), dismissButton: .default(Text("OK")))
        }
        .ignoresSafeArea(.keyboard)
    }
}

struct AccountRegister_Previews: PreviewProvider {
    static var previews: some View {
        AccountRegister()
    }
}
