//
//  Untitled.swift
//  RecipeViewer
//
//  Created by Waleed Jebrin on 05/02/2025.
//

struct RecipeResponse: Codable {
    let recipes : [Recipe]?
    let total : Int?
    let skip : Int?
    let limit : Int?
}

struct Recipe : Codable, Hashable {
    let id : Int?
    let name : String?
    let ingredients : [String]?
    let instructions : [String]?
    let prepTimeMinutes : Int?
    let cookTimeMinutes : Int?
    let servings : Int?
    let difficulty : String?
    let cuisine : String?
    let caloriesPerServing : Int?
    let tags : [String]?
    let userId : Int?
    let image : String?
    let rating : Double?
    let reviewCount : Int?
    let mealType : [String]?
    
    func getName() -> String {
        return name ?? ""
    }
    
    func getIngredients() -> String {
        return ingredients?.joined(separator: ", ") ?? ""
    }
    
    func getInstructions() -> [String] {
        return instructions ?? []
    }
    
    func getImage() -> String {
        return image ?? ""
    }
    
    func getTags() -> String {
        return tags?.joined(separator: ", ") ?? ""
    }
    
    func getRating() -> String {
        guard let rating = rating else {
            return ""
        }
        let n = 1/0.5
        let numberToRound = rating * n
        return "\(numberToRound.rounded() / n)"
    }
}
