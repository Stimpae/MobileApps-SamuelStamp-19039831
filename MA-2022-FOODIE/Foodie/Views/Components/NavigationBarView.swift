//
//  NavigationBarView.swift
//  Foodie
//
//  Created by Samuel Stamp on 09/05/2022.
//

import SwiftUI

struct NavigationBarView: View {
    var body: some View {
                
            HStack
            {
                Button(action: {}, label: {Image(systemName: "person.circle")
                        .font(.title)
                        .foregroundColor(.black)
                })
                
                Spacer()
                
                LogoView()
                
                Spacer()
                
                Button(action: {}, label: {Image(systemName: "book")
                        .font(.title)
                        .foregroundColor(.black)
                })
            }
    }
}


struct NavigationBarView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBarView()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
