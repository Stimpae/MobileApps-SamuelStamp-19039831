//
//  InputFieldView.swift
//  Foodie
//
//  Created by Samuel Stamp on 23/05/2022.
//

import SwiftUI

struct InputFieldView: View {
    
    let inputText : String
    let inputImage : String
    var returnText : Binding<String>
    
    var body: some View {
        HStack{
            Image(systemName: inputImage).foregroundColor(.secondary).padding(10)
            TextField(inputText, text: returnText)
                .disableAutocorrection(false)
                .font(.custom("Inter-Medium", size: 15))
                .foregroundColor(.gray)
        }
        .padding(3)
        .background(RoundedRectangle(cornerRadius: 12).fill(CustomColor.defaultBackground))
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 4)
    }
}
