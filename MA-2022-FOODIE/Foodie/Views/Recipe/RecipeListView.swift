//
//  RecipeListView.swift
//  Foodie
//
//  Created by Samuel Stamp on 10/05/2022.
//

import SwiftUI

struct RecipeListView: View {
    
    @ObservedObject var model: RecipeCardViewModel
    @EnvironmentObject var userData : UserData
    
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
        
    @State var searchText = ""
    
    @State var displayBin = false;

    var body: some View {
 
        ZStack{
    
            CustomColor.background.ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 0)
            {
                Spacer()
                
                HStack{
                    
                    Spacer()
                    
                    Image(systemName: displayBin == true ? "trash.fill" : "trash")
                        .padding(.horizontal)
                        .font(.system(size: 23))
                        .foregroundColor(displayBin == true ? .red : .black)
                        .onTapGesture(perform: {
                            displayBin.toggle()
                        })
                }
                
                Text("Saved Recipes")
                    .padding(.horizontal)
                    .font(.custom("Garet-Heavy", size: 30))
                    .foregroundColor(CustomColor.blue)
                    .multilineTextAlignment(.leading)
                
                SearchBar(searchText: $searchText)

                Spacer()
                
                List{
                    ForEach(userData.savedRecipes.filter({ (recipe : Recipe) -> Bool in return recipe.title.hasPrefix(searchText) || searchText == ""
                        
                    }), id: \.self){ recipe in
                        RecipeViewTest(model: model, recipe: recipe, showBin: displayBin)
                    }
                }
                .listRowSeparator(.hidden)
                .listRowBackground(CustomColor.background)
                .gesture(DragGesture()
                            .onChanged({ _ in
                    UIApplication.shared.dismissKeyboard()
                }))
            }
            .padding()
        }
    }
}

struct RecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListView(model: RecipeCardViewModel()).environmentObject(UserData())
    }
}

struct RecipeViewTest: View {
    
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    
    @ObservedObject var model: RecipeCardViewModel
    @EnvironmentObject var userData : UserData
    
    @State var recipe : Recipe
    var showBin : Bool
    
    @State private var showRecipe = false
    
    var body: some View {
        
        HStack()
        {
            Image(recipe.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 80, height:80, alignment: .leading)
                .clipped()
                .cornerRadius(50)
            
            // Recipe Information
            VStack(alignment:.leading,spacing: 4)
            {
                Spacer()
                Text(recipe.title)
                    .textCase(.uppercase)
                    .font(.custom("Garet-Heavy", size: 16))
                    .foregroundColor(.black)

                Text("")
                    .font(.custom("Inter-Medium", size: 14))
                    .foregroundColor(CustomColor.blue)
                Spacer()
            }
            
            Spacer()
            
            ZStack{
                
                if(!showBin)
                {
                    Image(systemName: "chevron.right")
                        .foregroundColor(CustomColor.orange)
                        .frame(width: 40, height: 40)
                } else{
                    Image(systemName: "trash.fill")
                        .font(.system(size: 23))
                        .foregroundColor(.red)
                        .onTapGesture(perform: {
                            userData.removeSavedRecipe(recipe: self.recipe)
                        })
                }
            }
            
        }
        .sheet(isPresented: $showRecipe)
        {
            RecipeView(model: model, recipe: recipe)
        }
        .onTapGesture {
            showRecipe.toggle()
        }
        
        .cornerRadius(30)
        
    }
}

struct SearchBar: View {
    
    @Binding var searchText : String
    
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundColor(.white)
                .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 4)
            
            HStack{
                Image(systemName: "magnifyingglass")
                TextField("Search..", text: $searchText)
                    .font(.custom("Inter-Medium", size: 15))
            }
            .foregroundColor(.gray)
            .padding(.leading, 13)
            
        }
        .frame(height:50)
        .cornerRadius(12)
        .padding(.horizontal)
    }
}
