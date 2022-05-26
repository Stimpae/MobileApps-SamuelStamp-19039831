//
//  RecipeCardView.swift
//  Foodie
//
//  Created by Samuel Stamp on 09/05/2022.
//

import SwiftUI

struct RecipeCardView: View {
    
    @ObservedObject var model: RecipeCardViewModel
    @State private var thumbnailImage: Image? = nil
    
    @State private var translation: CGSize = .zero
    private let randomValue = Double.random(in: 0..<50)
    
    private enum LikeDislikeStatus: Int{
        case like, dislike, none
    }
    
    @State private var swipeStatus: LikeDislikeStatus = .none
    
    var recipe: Recipe
    
    private var onRemove: (_ recipe: Recipe) -> Void
    private var onSave: (_ recipe: Recipe) -> Void

    // need a button to view the recipe as well before liking // get these others working first
    
    private var thresholdPercent: CGFloat = 0.5
    private var swipeThresholdPrecent: CGFloat = 0.2
    
    init(onRemove: @escaping (_ recipe: Recipe) -> Void, onSave: @escaping (_ recipe: Recipe) -> Void, recipes: Recipe, model: RecipeCardViewModel) {
        self.onRemove = onRemove
        self.onSave = onSave
        self.recipe = recipes
        self.model = model
    }
    
    private func getGesturePercentage(_ geometry: GeometryProxy, from gesture: DragGesture.Value) -> CGFloat{
        gesture.translation.width / geometry.size.width
    }
    
    public func likeRecipe()
    {
        //onSave(self.recipeOld)
    }
    
    public func dislikeRecipt()
    {
        //onRemove(self.recipeOld)
    }
    
    var body: some View {
        
        GeometryReader { geometry in
            VStack(alignment: .leading)
            {
    
                ZStack(alignment: self.swipeStatus == .like ? .topLeading : .topTrailing){
                    Image("1")
                        .resizable()
                        .scaledToFill()
                        .frame(width: geometry.size.width, height: geometry.size.height * 0.65)
                        .clipped()
                    
                    if self.swipeStatus == .like{
                        Text("YES PLEASE")
                            .font(.custom("Garet-Heavy", size: 18))
                            .padding()
                            .cornerRadius(10)
                            .foregroundColor(CustomColor.green)
                            .overlay(
                                
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(CustomColor.green, lineWidth: 3.0)
                            ).padding(24)
                            .rotationEffect(Angle.degrees(-20))
                    } else if self.swipeStatus == .dislike{
                        Text("NOPE")
                            .font(.custom("Garet-Heavy", size: 18))
                            .padding()
                            .cornerRadius(10)
                            .foregroundColor(CustomColor.orange)
                            .overlay(
                                
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(CustomColor.orange, lineWidth: 2.0)
                                    
                            ).padding(.top, 45)
                            .rotationEffect(Angle.degrees(20))
                    }
                }
                 
                // hstack for the recipe details (name, cusine, cooking time)
                HStack{
                    VStack(alignment: .leading, spacing: 2){
                  
                        Text(recipe.title)
                            .textCase(.uppercase)
                            .font(.custom("Garet-Heavy", size: 18))
                            .foregroundColor(.black)
    
                        Text("default")
                            .font(.custom("Inter-Medium", size: 17))
                            .foregroundColor(CustomColor.blue)
                        
                        
                        HStack{
                            
                            Text(Image(systemName: "clock")) + Text("  \(recipe.readyInMinutes)")
                                .font(.custom("Inter-Regular", size: 15))
                                .foregroundColor(.black)
                            
                            Spacer()
                            
                            Text(Image(systemName: "person.3")) + Text("  \(recipe.servings)")
                                .font(.custom("Inter-Regular", size: 15))
                                .foregroundColor(.black)
                            
                            Spacer()
                            
                            Text(Image(systemName: "flame")) + Text(" \(recipe.spoonacularScore)")
                                .font(.custom("Inter-Regular", size: 15))
                                .foregroundColor(.black)
                        }
                        
                        Spacer()
                    
                    }
                    Spacer()

                }
                .padding(.horizontal, 20.0)
                
                Divider()
                
                HStack{
                    // need to check for preferences / allergys?
                    AllergenOptionView()
                }
                .padding(.horizontal, 20.0)
            }
            .padding(.bottom)
            .background(Color.white)
            .cornerRadius(20)
            .offset(x: self.translation.width, y: 0)
            .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 3)
            .animation(.interactiveSpring(), value: self.translation)
            .rotationEffect(.degrees(Double(self.translation.width / geometry.size.width) * randomValue), anchor: .bottom)
            .gesture(
                DragGesture()
                    .onChanged{ value in
                        self.translation = value.translation
                        
                        if(self.getGesturePercentage(geometry, from: value)) >= self.swipeThresholdPrecent{
                            self.swipeStatus = .like
                        }
                        else if self.getGesturePercentage(geometry, from: value) <= -self.swipeThresholdPrecent{
                            self.swipeStatus = .dislike
                        } else{
                            self.swipeStatus = .none
                        }
                    }
                    .onEnded{ value in
                        if abs(self.getGesturePercentage(geometry, from: value)) > self.thresholdPercent{
                            if(self.swipeStatus == .like)
                            {
                                //self.onSave(self.recipeOld)
                            }
                            else{
                                //self.onRemove(self.recipeOld)
                            }
                        } else{
                            
                            self.swipeStatus = .none
                            self.translation = .zero
                        }
                    })
        }

        
    }
}

struct RecipeCardView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeCardView(onRemove: {_ in}, onSave: {_ in}, recipes: Recipe.example, model: RecipeCardViewModel())
            .padding()
            .frame(height: 400)
    }
}
