//
//  Recipe.swift
//  Foodie
//
//  Created by Samuel Stamp on 25/05/2022.
//

import Foundation

struct Recipe: Codable, Identifiable, Hashable{
    var id: Int
    var title: String
    var image: String
    var servings: Int
    var readyInMinutes: Int
    var sourceURL: String?
    var cuisines: [String]
    var spoonacularScore: Int
}

extension Recipe {
    static let empty = Recipe(id: -1, title: "", image: "", servings: 0, readyInMinutes: 0, sourceURL: nil, cuisines: [], spoonacularScore: 0)
    static let example = Recipe(id: 1, title: "Sample", image: "", servings: 3, readyInMinutes: 10, sourceURL: "", cuisines: ["American"], spoonacularScore: 10)
}
