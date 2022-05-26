//
//  LogoView.swift
//  Foodie
//
//  Created by Samuel Stamp on 09/05/2022.
//

import SwiftUI

struct LogoView: View {
    var body: some View {
        HStack(spacing: 4)
        {
            // need to convert this to a button so we can return to the main view
            Text("FOODIE".uppercased())
                .font(.title3)
                .fontWeight(.black)
                .foregroundColor(.black)
        }
    }
}

struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        LogoView()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
