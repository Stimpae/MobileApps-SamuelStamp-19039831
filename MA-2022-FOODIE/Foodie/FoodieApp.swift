//
//  FoodieApp.swift
//  Foodie
//
//  Created by Samuel Stamp on 02/05/2022.
//

import SwiftUI
import FirebaseCore
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
      
    FirebaseApp.configure()

    return true
  }
}

@main
struct FoodieApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var userData = UserData()
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(userData)
        }
    }
}


