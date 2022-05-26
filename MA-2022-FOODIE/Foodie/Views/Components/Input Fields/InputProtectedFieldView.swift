//
//  InputProtectedFieldView.swift
//  Foodie
//
//  Created by Samuel Stamp on 23/05/2022.
//

import SwiftUI

struct InputProtectedFieldView: View {
    
    let inputText : String
    let inputImage : String
    var returnText : Binding<String>
    
    @State private var showField : Bool = false
    
    var body: some View {
        
        HStack{
            Image(systemName: inputImage).foregroundColor(.secondary).padding(10)
            
            if showField {
                TextField(inputText, text: returnText)
                    .disableAutocorrection(true)
                    .font(.custom("Inter-Medium", size: 15))
                    .foregroundColor(.gray)
                    
            }
            else
            {
                SecureField(inputText, text: returnText)
                    .disableAutocorrection(true)
                    .font(.custom("Inter-Medium", size: 15))
                    .foregroundColor(.gray)
            }
            Button(action: {self.showField.toggle()})
            {
                Image(systemName: "eye")
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal)
          
        }
        .padding(3)
        .background(RoundedRectangle(cornerRadius: 12).fill(CustomColor.defaultBackground))
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 4)
    }
}

