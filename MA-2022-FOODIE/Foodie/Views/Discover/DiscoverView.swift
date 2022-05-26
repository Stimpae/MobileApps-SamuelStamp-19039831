//
//  RecipeSwipeView.swift
//  Foodie
//
//  Created by Samuel Stamp on 10/05/2022.
//

import SwiftUI


struct DiscoverView: View {

    @ObservedObject var model: RecipeCardViewModel
    @EnvironmentObject var userData : UserData
    
    @State private var offset = CGSize(width: 0, height: 0)
    
    private func getCardWidth(_ geometry: GeometryProxy, id: Int) -> CGFloat{
        let offset: CGFloat = CGFloat(model.recipes.count - 1 - id) * 10
        return geometry.size.width - offset
    }
    
    private func getCardOffer(_ geometry: GeometryProxy, id: Int) -> CGFloat{
        return CGFloat(model.recipes.count - 1 - id) * 11
    }
    
    private var maxID: Int{
        return model.recipes.map {$0.id}.max() ?? 0
    }
    
    @State var width = UIScreen.main.bounds.width
    @State var height = UIScreen.main.bounds.height
    
    @State var showSheet = false
    
    var body: some View {
        ZStack{
            
            CustomColor.background.ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 0) {
                
                Text("Discover")
                    .padding(.horizontal)
                    .font(.custom("Garet-Heavy", size: 30))
                    .foregroundColor(CustomColor.blue)
                    .multilineTextAlignment(.leading)
        
                GeometryReader{ geometry in
                        
                        if model.isLoading {
                            ForEach(0..<3) { _ in
                                
                                RecipeCardView(onRemove: {
                                    removed in
                                    
                                }, onSave: {
                                    saved in
                                    
                                }, recipes: Recipe.example, model: model)
                                    .animation(.spring(), value: 1)
                            }
                        }else if(!model.recipes.isEmpty) {

                            
                            ForEach(model.recipes) { recipe in
                                if(recipe.id > self.maxID - 3)
                                {
                                    RecipeCardView(onRemove: {
                                        removed in
                                        
                                        //model.recipes.removeAll() {$0.id == removed.id}
                            
                                    }, onSave: {
                                        saved in
                                        
                                        userData.addSavedRecipe(recipe: recipe)
   
                                        //model.recipes.removeAll() {$0.id == saved.id}
                                    }, recipes: recipe, model: model)
                                }
                            }
                        }else{
                            ForEach(0..<3) { _ in
                                
                                RecipeCardView(onRemove: {
                                    removed in
                                    
                                }, onSave: {
                                    saved in
                                    
                                }, recipes: Recipe.example, model: model)
                                    .animation(.spring(), value: 1)
                            }
                        }
                    
                }
                .padding(.horizontal)
                .frame(height: 500)
                
                HStack
                {
                    Button(action: {
                        
//                        if (!model.recipes.isEmpty){
//                            let r = model.recipes.last!
//
//                            // cant actually remove them yet
//                            model.recipes.removeAll() { $0.id == r.id}
//                        }
                        
                    }, label: {Image(systemName: "multiply")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding(.all, 18)
                            .background(CustomColor.orange)
                            .cornerRadius(40)
                            .shadow(color: Color.black.opacity(0.2), radius: 3, x: 0, y: 3)
                            .offset(y: -15)
                    })
                    
                    Spacer()
                    
                    Button(action: {
                        
                        if (!model.recipes.isEmpty){
                            showSheet.toggle()
                        }
     
                    }, label: {Image(systemName: "info")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding(.horizontal, 30)
                            .padding(.vertical, 27)
                            .background(CustomColor.blue)
                            .cornerRadius(40)
                            .shadow(color: Color.black.opacity(0.2), radius: 3, x: 0, y: 3)
                    })
                
                    Spacer()
                    
                    Button(action: {
                        
//                        if (!recipes.isEmpty){
//                            let r = recipes.last!
//                            userData.addSavedRecipe(recipe: r)
//                            self.recipes.removeAll() { $0.id == r.id}
//                        }
                        
                    }, label: {Image(systemName: "plus")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding(.all, 18)
                            .background(CustomColor.green)
                            .cornerRadius(40)
                            .shadow(color: Color.black.opacity(0.2), radius: 3, x: 0, y: 3)
                            .offset(y: -15)
                    })
                }
                .padding(.top, 10)
                .padding(.horizontal, 60)
        
       
            }
            .sheet(isPresented: $showSheet)
            {
                // shows the last element of the collection which should be the top one?
                RecipeView(model: model, recipe: model.recipes.last!)
            }
            .padding(.horizontal)
            
        }
        .onAppear{
            if model.recipes.isEmpty{
                model.getRandomRecipes()
            }
        }
    }
        
}

struct DiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView(model: RecipeCardViewModel())
    }
}
