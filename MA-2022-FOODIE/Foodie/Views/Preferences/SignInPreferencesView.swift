//
//  SignInPreferencesView.swift
//  Foodie
//
//  Created by Samuel Stamp on 23/05/2022.
//

import SwiftUI
import Firebase

struct SignInPreferencesView: View {
    
    @StateObject var Preferences : PreferencesManager
    
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
                        Text("Welcome \(userData.user.name)")
                            .font(.custom("Garet-Heavy", size: 34))
                            .foregroundColor(CustomColor.blue)
                            .multilineTextAlignment(.leading)
    
                        Text("Please select your favourite cuisines from the list below. Don't worry you can always change your decision later.")
                            .font(.custom("Inter-Regular", size: 15))
                            .foregroundColor(.black)
                            .multilineTextAlignment(.leading)
                            .frame(width: width - 100)
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
                
                Button("CONTINUE"){
                    userData.isUserAuthenticated = .signedIn
                }
                .foregroundColor(Color.white)
                .font(Font.custom("Garet-Heavy", size: 15))
                .frame(width: width - 42, height: 50, alignment: .center)
                .background(CustomColor.orange)
                .cornerRadius(12)
                .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 4)
                
                Spacer()

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

struct SignInPreferencesView_Previews: PreviewProvider {
    static var previews: some View {
        SignInPreferencesView(Preferences: PreferencesManager())
    }
}
