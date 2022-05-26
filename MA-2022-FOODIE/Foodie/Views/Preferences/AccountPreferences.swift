//
//  AccountPreferences.swift
//  Foodie
//
//  Created by Samuel Stamp on 25/05/2022.
//

import SwiftUI
import Firebase

struct AccountPreferences: View {
    
    @StateObject var Preferences : PreferencesManager
    
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var userData : UserData
    
    @State var width = UIScreen.main.bounds.width
    @State var height = UIScreen.main.bounds.height
    
    var body: some View {
        ZStack{
            CustomColor.background.ignoresSafeArea()
        
            VStack{
                
                Spacer()
                
                HStack
                {
                    VStack(alignment: .leading)
                    {
                        Text("Hi, \(userData.user.name)")
                            .font(.custom("Garet-Heavy", size: 34))
                            .foregroundColor(CustomColor.blue)
                            .multilineTextAlignment(.leading)
    
                        Text("Please select your favoutrite cuisines from the list below.")
                            .font(.custom("Inter-Regular", size: 15))
                            .foregroundColor(.black)
                    }
                    .padding()
                    
                    Spacer()
                }
                
                ScrollView(showsIndicators: false){
                        PreferencesCloudView(preferencesManager: Preferences)
                }
                .labelsHidden()
                .padding([.horizontal])
                .frame(height: height / 1.9)
                
                Spacer()
                
                Button(action:{
                    dismiss()
                }) {Text("Cancel")
                        .foregroundColor(CustomColor.blue)
                        .font(Font.custom("Inter-Medium", size: 16))
                }

            }
        }
        .onAppear{
            guard let uid = Auth.auth().currentUser?.uid else{
                return
            }
            FBFirestore.retrieveFBUser(uid: uid) { (result) in
                switch result{
                case .failure(let error):
                    print(error.localizedDescription)
                case .success(let user):
                    self.userData.user = user
                }
            }
        }
    }
}

struct AccountPreferences_Previews: PreviewProvider {
    static var previews: some View {
        AccountPreferences(Preferences: PreferencesManager()).environmentObject(UserData())
    }
}
