//
//  NetworkManagerConstants.swift
//  RecipeViewer
//
//  Created by Waleed Jebrin on 05/02/2025.
//

public enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}

public struct EndPoint {
    let path: String

    public init(path: String) {
        self.path = path
    }
}
