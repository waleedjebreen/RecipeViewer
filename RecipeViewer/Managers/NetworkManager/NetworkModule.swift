//
//  NetworkWmodule.swift
//  RecipeViewer
//
//  Created by Waleed Jebrin on 05/02/2025.
//

import Foundation

public typealias Parameters = [String: Any]
public typealias Headers = [String: String]

public protocol NetworkModule {
    var method: RequestMethod { get }
    var bodyParameters: Parameters? { get }
    var queryParameters: Parameters? { get }
    var headers: Headers? { get }
    var endpoint: EndPoint { get }
    var timeout: TimeInterval { get }
    
    func buildURLRequest(baseURL: URL) -> URLRequest?
}

public extension NetworkModule {
    var method: RequestMethod { .get }
    var bodyParameters: Parameters? { nil }
    var queryParameters: Parameters? { nil }
    var headers: Headers? { ["Accept": "application/json"] }
    var timeout: TimeInterval { 30 }

    func buildURLRequest(baseURL: URL) -> URLRequest? {
        guard var url = URL(string: baseURL.absoluteString + endpoint.path) else { return nil }
        
        if let queryParameters = queryParameters {
            var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
            urlComponents?.queryItems = queryParameters.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
            url = urlComponents?.url ?? url
        }
        
        var request = URLRequest(url: url, timeoutInterval: timeout)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers

        if let bodyParameters = bodyParameters {
            request.httpBody = try? JSONSerialization.data(withJSONObject: bodyParameters)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }

        return request
    }
}
