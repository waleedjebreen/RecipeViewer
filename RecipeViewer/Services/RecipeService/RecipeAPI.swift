//
//  RecipeAPI.swift
//  RecipeViewer
//
//  Created by Waleed Jebrin on 05/02/2025.
//

struct RecipeAPI: NetworkModule {
    var method: RequestMethod
    var queryParameters: Parameters?
    var endpoint: EndPoint = EndPoint(path: "/recipes")
}
