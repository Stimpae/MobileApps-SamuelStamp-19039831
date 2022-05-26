//
//  FBKeys.swift
//  Foodie
//
//  Created by Samuel Stamp on 24/05/2022.
//

// Sourced - https://github.com/StewartLynch/FBAuthentication/tree/main/Sources/FBAuthentication/Firestore

import Foundation

enum FBKeys {
    
    enum CollectionPath {
        static let users = "users"
    }
    
    enum User {
        static let uid = "uid"
        static let name = "name"
        static let email = "email"
        
        // Add app specific keys here
        static let firstTime = "firstTime"
       
    }
}
