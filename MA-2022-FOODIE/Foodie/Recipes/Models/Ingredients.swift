//
//  Ingredients.swift
//  Foodie
//
//  Created by Samuel Stamp on 25/05/2022.
//

import Foundation

struct Ingredients: Codable, Identifiable {
    var id : Int
    var name : String
    var amount : Int
}
