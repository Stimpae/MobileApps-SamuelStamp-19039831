//
//  AllergenOptionView.swift
//  Foodie
//
//  Created by Samuel Stamp on 09/05/2022.
//

import SwiftUI

struct AllergenOptionView: View {
    
    // need a public image variable to set the image depdentent on things
    
    var body: some View {
        HStack{
            Image(systemName: "leaf.fill")
                .resizable()
                .foregroundColor(.white)
                .frame(width: 12.0, height: 12.0)
        }
        .padding(.all, 8)
        .background(Color(hue: 0.392, saturation: 0.84, brightness: 0.869))
        .cornerRadius(20)
        
    }
}

struct AllergenOptionView_Previews: PreviewProvider {
    static var previews: some View {
        AllergenOptionView()
            .padding()
    }
}
