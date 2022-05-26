//
//  SelectionBarView.swift
//  Foodie
//
//  Created by Samuel Stamp on 09/05/2022.
//

import SwiftUI

struct SelectionBarView: View {
    var body: some View {

        HStack
        {
            Button(action: {}, label: {Image(systemName: "multiply")
                    .font(.title)
                    .foregroundColor(.red)
                    .padding(.all)
                    .background(.white)
                    .cornerRadius(40)
                    .shadow(color: Color.black.opacity(0.2), radius: 3, x: 0, y: 3)
            })
            
            Spacer()
            
            Button(action: {}, label: {Image(systemName: "info")
                    .font(.title)
                    .foregroundColor(.blue)
                    .padding(.horizontal, 30)
                    .padding(.vertical, 27)
                    .background(.white)
                    .cornerRadius(40)
                    .shadow(color: Color.black.opacity(0.2), radius: 3, x: 0, y: 3)
            })
        
            Spacer()
            
            Button(action: {}, label: {Image(systemName: "plus")
                    .font(.title)
                    .foregroundColor(.green)
                    .padding(.all)
                    .background(.white)
                    .cornerRadius(40)
                    .shadow(color: Color.black.opacity(0.2), radius: 3, x: 0, y: 3)
            })
        }
    }
}

struct SelectionBarView_Previews: PreviewProvider {
    static var previews: some View {
        SelectionBarView()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
