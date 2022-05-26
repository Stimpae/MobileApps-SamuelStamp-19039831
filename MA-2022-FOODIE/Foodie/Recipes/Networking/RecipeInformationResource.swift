//
//  RecipeInformationResource.swift
//  Foodie
//
//  Created by Samuel Stamp on 25/05/2022.
//

import Foundation

struct RecipeInformationResource: APIResource {
    typealias ModelType = [Recipe]
    
    var methodPath: String {
        return "/recipes/informationBulk"
    }
    
    var tags: [String: String]?
    var number: [String: String]?
}
