//
//  RecipeAPI.swift
//  RecipeViewer
//
//  Created by Waleed Jebrin on 05/02/2025.
//

enum RecipeModule: NetworkModule {
    
    case recipiesList(limit: Int, skip: Int)
    case searchRecipes(query: String?, sortOption: String?, limit: Int, skip: Int)
    
    var method: RequestMethod {
        switch self {
        case .recipiesList, .searchRecipes:
            return .get
        }
    }
    
    var queryParameters: Parameters? {
        switch self {
        case let .recipiesList(limit, skip):
            return ["limit": limit, "skip": skip]
        case let .searchRecipes(query, sortOption, limit, skip):
            var params = [String: Any]()
            params["limit"] = limit
            params["skip"] = skip
            if let query = query {
                params["q"] = query
            }
            if let sortOption = sortOption {
                params["sortBy"] = "name"
                params["order"] = sortOption
            }
            return params
        }
    }
    
    var endpoint: EndPoint {
        switch self {
        case .recipiesList:
            return EndPoint(path: "/recipes")
        case .searchRecipes(let query, _, _, _):
            if query != nil {
                return EndPoint(path: "/recipes/search")
            }
            return EndPoint(path: "/recipes")
        }
    }
}
