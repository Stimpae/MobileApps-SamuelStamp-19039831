//
//  ForgotPasswordView.swift
//  Foodie
//
//  Created by Samuel Stamp on 24/05/2022.
//

import SwiftUI

struct ForgotPasswordView: View {
    
    @State var user: UserViewModel = UserViewModel()
    
    @Environment(\.dismiss) var dismiss
    
    @State var width = UIScreen.main.bounds.width
    @State var height = UIScreen.main.bounds.height
    
    @State private var showAlert = false
    @State private var errString: String?
    
    var body: some View {
        ZStack{
            
            CustomColor.background.ignoresSafeArea()
            
            VStack{
                
                Spacer()
                
                HStack
                {
                    VStack
                    {
                        Text("Recover Password.")
                            .font(.custom("Garet-Heavy", size: 36))
                            .foregroundColor(CustomColor.blue)
                            .multilineTextAlignment(.leading)
                            .frame(width: width / 1.8, height: 110, alignment: .leading)
                        
                        Text("Enter valid email address to reset your password")
                            .font(.custom("Inter-Regular", size: 17))
                            .foregroundColor(CustomColor.orange)
                            .multilineTextAlignment(.leading)
                            .frame(width: width / 1.8, alignment: .leading)
                            .offset(y: -10)
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                    
                }
                
                InputFieldView(inputText: "Email Address", inputImage: "envelope", returnText: $user.email).padding([.leading, .bottom, .trailing])
                
                
                Button(action: {
                    FBAuth.resetPassword(email: self.user.email) { (result) in
                        switch result{
                        case .failure(let error):
                            self.errString = error.localizedDescription
                        case .success( _):
                            break
                        }
                        self.showAlert = true
                    }
                }) {Text("RECOVER")
                        .foregroundColor(Color.white)
                        .font(Font.custom("Garet-Heavy", size: 15))
                        .frame(width: width - 42, height: 50, alignment: .center)
                        .background(CustomColor.orange)
                        .cornerRadius(12)
                        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 4)
                        .padding(.horizontal)
                }
                .disabled(!user.isEmailValid(email: user.email))
                .opacity(user.isEmailValid(email: user.email) ? 1 : 0.5)
                
                Spacer()
                
                Button(action:{
                    dismiss()
                }) {Text("Cancel")
                        .foregroundColor(CustomColor.blue)
                        .font(Font.custom("Inter-Medium", size: 16))
                }
                
                Spacer()
            }
            .padding()
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Password Reset"), message: Text(self.errString ?? "Success. Reset email sent successfully. Check your email"), dismissButton: .default(Text("OK")){
                    dismiss()
                })
                
            }
        }
        .ignoresSafeArea(.keyboard)
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
