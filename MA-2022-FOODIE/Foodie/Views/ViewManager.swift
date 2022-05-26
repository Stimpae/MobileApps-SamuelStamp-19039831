//
//  ViewManager.swift
//  Foodie
//
//  Created by Samuel Stamp on 10/05/2022.
//

import Foundation
import SwiftUI

class ViewManager: ObservableObject{
    @Published var currentView: TabViews = .recipes
    
    
}

enum TabViews{
    case account
    case discover
    case recipes
}

enum LoginViews{
    case main
    case login
    case register
}
