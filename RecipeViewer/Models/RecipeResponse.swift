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
    
    init(recipes: [Recipe]?, total: Int?, skip: Int?, limit: Int?) {
        self.recipes = recipes
        self.total = total
        self.skip = skip
        self.limit = limit
    }
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
    
    init(id: Int?, name: String?, ingredients: [String]?, instructions: [String]?, prepTimeMinutes: Int?, cookTimeMinutes: Int?, servings: Int?, difficulty: String?, cuisine: String?, caloriesPerServing: Int?, tags: [String]?, userId: Int?, image: String?, rating: Double?, reviewCount: Int?, mealType: [String]?) {
        self.id = id
        self.name = name
        self.ingredients = ingredients
        self.instructions = instructions
        self.prepTimeMinutes = prepTimeMinutes
        self.cookTimeMinutes = cookTimeMinutes
        self.servings = servings
        self.difficulty = difficulty
        self.cuisine = cuisine
        self.caloriesPerServing = caloriesPerServing
        self.tags = tags
        self.userId = userId
        self.image = image
        self.rating = rating
        self.reviewCount = reviewCount
        self.mealType = mealType
    }
    
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
