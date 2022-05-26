//
//  PreferencesCloudView.swift
//  Foodie
//
//  Created by Samuel Stamp on 23/05/2022.
//

import SwiftUI

struct PreferencesCloudView: View {
    
    @StateObject var preferencesManager : PreferencesManager
    
    @EnvironmentObject var userData : UserData
    
    @State private var totalHeight = CGFloat.zero
    
    var body: some View {
        VStack{
            GeometryReader{
                geometry in
                
                var width = CGFloat.zero
                var height = CGFloat.zero
                
                ZStack(alignment: .topLeading){
                    ForEach(userData.preferences, id: \.self) { pref in
                        PreferenceItem(preference: pref)
                            .padding([.horizontal, .vertical], 4)
                            .alignmentGuide(.leading, computeValue: {
                                d in
                                if(abs(width - d.width) > geometry.size.width)
                                {
                                    width = 0
                                    height -= d.height
                                }
                                
                                let result = width
                                
                                if pref == self.userData.preferences.last! {
                                    width = 0
                                } else{
                                    width -= d.width
                                }
                                
                                return result
                            })
                            .alignmentGuide(.top, computeValue: {
                                d in
                                
                                let result = height
                                if pref == self.userData.preferences.last! {
                                    height = 0
                                }
                                return result
                            })
                    }
                }.background(viewHeightReader($totalHeight))
            }
        }
        .frame(height: totalHeight)
    }
    
    private func viewHeightReader(_ binding: Binding<CGFloat>) -> some View{
        return GeometryReader {
            geometry -> Color in
            let rect = geometry.frame(in: .local)
            DispatchQueue.main.async{
                binding.wrappedValue = rect.size.height
            }
            return .clear
        }
    }

}

struct PreferenceItem : View{
    
    @State var preference : String
    @State var width = UIScreen.main.bounds.width
    
    @EnvironmentObject var userData : UserData
    
    var body: some View{

        Button(preference){
            if(!userData.doesSavedContain(name: preference))
            {
                userData.addToSavedPreferences(name: preference)
            }
            else
            {
                userData.removeFromSavedPreferences(name: preference)
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
        .foregroundColor(Color.black)
        .font(Font.custom("Inter-Regular", size: 15))
        .background(userData.doesSavedContain(name: preference) ? CustomColor.green : CustomColor.defaultBackground)
        .cornerRadius(12)
        
    }
}

