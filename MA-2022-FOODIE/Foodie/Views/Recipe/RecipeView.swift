//
//  RecipeView.swift
//  Foodie
//
//  Created by Samuel Stamp on 10/05/2022.
//

import SwiftUI

struct RecipeView: View {
    
    @ObservedObject var model: RecipeCardViewModel
    @State var recipe : Recipe
    @State private var thumbnailImage: Image? = nil
    
    @Environment(\.dismiss) var dismiss
    
    @State var width = UIScreen.main.bounds.width
    @State var height = UIScreen.main.bounds.height
    
    var body: some View {
        ZStack{
            
            VStack{
                
                ZStack{
                    Image("1")
                        .resizable()
                        .scaledToFill()
                        .frame(width: width, height: height * 0.5)
                        .clipped()
                        .offset(y: 10)
                        .ignoresSafeArea(edges: .top)
                    
                    
                    HStack{
                        
                        Spacer()
                        
                        VStack{
                            
                            Spacer()
                            
                            Image(systemName: "chevron.down")
                                .padding(.horizontal, 22)
                                .font(.system(size: 30))
                                .foregroundColor(.white)
                                .onTapGesture(perform: {
                                    dismiss()
                                })
                        }
                        
                    }
                
                }
                ZStack{
                    CustomColor.background
                    ScrollView{
                        
                        VStack(alignment: .leading){
                            Text("")
                                .font(.custom("Inter-Medium", size: 20))
                                .foregroundColor(CustomColor.blue)
                
                            Text(recipe.title)
                                .textCase(.uppercase)
                                .font(.custom("Garet-Heavy", size: 25))
                                .foregroundColor(.black)
                                .padding(.bottom,2)
                            
                            HStack{
                                
                                ZStack{
                                    CustomColor.green
                                    VStack{
                                    Image(systemName: "clock")
                                            .padding(.all, 3)
                                            .font(.system(size: 26))
                                    Text("\(recipe.readyInMinutes) Minutes")
                                       .font(.custom("Inter-Regular", size: 14))
                                       .foregroundColor(.black)
                                       .frame(width: width / 6)
                                       .multilineTextAlignment(.center)
                                        
                                    }
                                }
                                .frame(width: width / 4, height: height / 7)
                                .cornerRadius(12)
                                .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 3)
                            
                                Spacer()
                                
                                ZStack{
                                    CustomColor.lightBlue
                                    VStack{
                                    Image(systemName: "person.3")
                                            .padding(.all, 3)
                                            .font(.system(size: 24))
                                        Text("\(recipe.servings) Servings")
                                       .font(.custom("Inter-Regular", size: 14))
                                       .foregroundColor(.black)
                                       .multilineTextAlignment(.center)
                                       .frame(width: width / 6)
                                    }
                                }
                                .frame(width: width / 4, height: height / 7)
                                .cornerRadius(12)
                                .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 3)
                                
                                Spacer()
                                
                                ZStack{
                                    CustomColor.yellow
                                    VStack{
                                    Image(systemName: "flame")
                                            .padding(.all, 3)
                                            .font(.system(size: 26))
                                    Text("\(recipe.spoonacularScore) Calories")
                                       .font(.custom("Inter-Regular", size: 14))
                                       .foregroundColor(.black)
                                       .multilineTextAlignment(.center)
                                       .frame(width: width / 6)
                                    }
                                }
                                .frame(width: width / 4, height: height / 7)
                                .cornerRadius(12)
                                .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 3)
                            
                            }
                            
                            
                            Text("Ingredients")
                                .font(.custom("Garet-Heavy", size: 25))
                                .foregroundColor(CustomColor.blue)
                                .padding(.bottom,2)
                            
                            // need an array of ingredients here and construct it in the correct colums
                            
                            
                            Text("Directions")
                                .font(.custom("Garet-Heavy", size: 25))
                                .foregroundColor(CustomColor.blue)
                                .padding(.bottom,2)
                            
                            // get all the steps in an array and list them here
                            
                        }
                        .padding(.all, 5)
                        
                        
                    }
                    .padding()
                }.frame(height: height * 0.55)
                    
            
            }

        }
    }
}

struct RecipeView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView(model: RecipeCardViewModel(), recipe: Recipe.example)
    }
}
