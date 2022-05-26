//
//  RecipeCardViewModel.swift
//  Foodie
//
//  Created by Samuel Stamp on 25/05/2022.
//

import Foundation

class RecipeCardViewModel: ObservableObject {
    @Published private(set) var recipes: [Recipe] = []
    @Published private(set) var isLoading = false
    
    private var request: APIRequest<RecipeInformationResource>?
    
    func getRandomRecipes() {
        guard !isLoading else { return }
        isLoading = true
        
        var resource = RecipeInformationResource()
        
        resource.tags = ["ids": "715538,716429"]
        
        let request = APIRequest(resource: resource)
        self.request = request
        request.execute { [weak self] recipes in
            self?.recipes = recipes ?? []
            self?.isLoading = false
        }
    }
    
    func downloadImage(from url: URL, completion: @escaping(Result<Data, Error>) -> ()) {
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else {
                return
            }
            completion(.success(data))
        }.resume()
    }
}
