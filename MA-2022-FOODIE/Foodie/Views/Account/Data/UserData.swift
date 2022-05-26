//
//  UserData.swift
//  Foodie
//
//  Created by Samuel Stamp on 23/05/2022.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import SwiftUI

public  class UserData: ObservableObject {
    
    // available recipe data
    @State var preferences: [String] = [
        "African",
        "German",
        "Mediterranean",
       "American",
        "Greek",
       "Mexican",
        "British",
        "Indian",
        "Middle Eastern",
        "Cajun",
        "Irish",
        "Nordic",
        "Caribbean",
        "Italian",
        "Southern",
        "Chinese",
        "Japenese",
        "Spanish",
        "Eastern European",
        "Jewish",
        "Thai",
        "European",
        "Korean",
        "Vietnamese",
        "French",
        "Latin American",
    ]
    
    @Published var isUserAuthenticated : AuthState = .undefined
    @Published var user: FBUser = .init(uid: "", name: "", email: "", firstTime: "")
    
    @Published var savedRecipes : [Recipe] = []
    @Published var savedPreferences: [String] = []
    
        
    var authStateDidChangeListenerHandle: AuthStateDidChangeListenerHandle?
    
    func configureFirebaseStateDidChange(){
        authStateDidChangeListenerHandle = Auth.auth().addStateDidChangeListener({ (_, user) in
            guard let user = user else {
                self.isUserAuthenticated = .signedOut
                return
            }
            
            self.isUserAuthenticated = .signedIn
            FBFirestore.retrieveFBUser(uid: user.uid) { (result) in
                            switch result {
                            case .failure(let error):
                                print(error.localizedDescription)
                            case .success(let user):
                                self.user = user
                            }
                        }
        })
    }
    
    public func addToSavedPreferences(name : String){
        if(!savedPreferences.contains(name))
        {
            savedPreferences.append(name)
        }
    }
    
    public func removeFromSavedPreferences(name : String){
        if(savedPreferences.contains(name))
        {
            savedPreferences = savedPreferences.filter {$0 != name}
        }
    }
    
    public func doesSavedContain(name: String) -> Bool{
        if(savedPreferences.contains(name))
        {
            return true
        }
        else{
            return false
        }
    }
    
    func addSavedRecipe(recipe : Recipe)
    {
        /*
        if(!savedRecipes.contains(recipe))
        {
            savedRecipes.append(recipe)
        }
         */
    }
    
    func removeSavedRecipe(recipe : Recipe)
    {
        /*
        if(savedRecipes.contains(recipe))
        {
            savedRecipes = savedRecipes.filter {$0 != recipe}
        }
         */
    }
    
    
}

enum AuthState{
    case undefined
    case signedOut
    case signInFirstTime
    case signedIn
}
