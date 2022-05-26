//
//  ContentView.swift
//  Foodie
//
//  Created by Samuel Stamp on 02/05/2022.
//

import SwiftUI


struct ContentView: View {
    
    @EnvironmentObject var userData : UserData
    
    @State var width = UIScreen.main.bounds.width
    @State var height = UIScreen.main.bounds.height
    
    var body: some View {
        Group{
            if userData.isUserAuthenticated == .undefined{
            }
            else if userData.isUserAuthenticated == .signedOut{
                AccountMain()
            }
            else if userData.isUserAuthenticated == .signedIn
            {
                MainView()
            }
            else
            {
                MainView()
            }
        }
        .onAppear{
            self.userData.configureFirebaseStateDidChange()
        }
    }

}

extension UIApplication{
    func dismissKeyboard(){
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portrait)
    }
}


