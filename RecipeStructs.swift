//
//  File.swift
//  Food Mood
//
//  Created by Nikita Kuznetsov on 10.04.2023.
//


import RealmSwift
import Foundation

var resultRecipes = [Recipe]()

class RecipeResponse: Object, Codable {
    var hits = List<RecipeInfo>()
}

class RecipeInfo: EmbeddedObject, Codable {
    @objc dynamic var recipe: Recipe?
}

class Recipe: Object, Codable {
    @objc dynamic var label: String = ""
    @objc dynamic var yield: Int = 0
    var ingredientLines = List<String>()
    @objc dynamic var image: String = ""
}




