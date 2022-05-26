//
//  MainView.swift
//  Foodie
//
//  Created by Samuel Stamp on 24/05/2022.
//

import SwiftUI
import Firebase

struct MainView: View {
    
    @StateObject var model = RecipeCardViewModel()
    
    @EnvironmentObject var userData : UserData
    
    @State private var tabSelection = 2
    
    var body: some View {
        
        TabView(selection: $tabSelection){
            
            AccountView()
                .tabItem{
                    Image(systemName: "person")
                }
                .tag(1)
            
            DiscoverView(model: model)
                .tabItem{
                    Image(systemName: "circle.grid.3x3")
                }
                .tag(2)

            RecipeListView(model: model)
                .tabItem{
                    Image(systemName: "book")
                }
                .tag(3)
        }
        .onAppear(){
            UIFont.systemFont(ofSize: 60)
            UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 100)], for: .normal)
            
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

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(model: RecipeCardViewModel())
    }
}
