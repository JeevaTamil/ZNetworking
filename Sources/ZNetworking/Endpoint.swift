//
//  File.swift
//  
//
//  Created by Azhagusundaram Tamil on 27/06/22.
//

import Foundation

struct Endpoint<Kind: EndpointKind, Response: Decodable> {
    var path: String
    var queryItems = [URLQueryItem]()
}

public class Endpoints {
    var host: String
    var scheme: String = "https"
    //    var queryItems = [URLQueryItem]()
    
    public init(host: String) {
        self.host = host
    }
    
    public func constructURL(path: String, queryItems: [URLQueryItem] = []) -> URL {
        var components = URLComponents()
        components.host = host
        components.scheme = scheme
        components.queryItems = queryItems
        components.path = "/" + path
        
        
        
        guard let url = components.url else {
            preconditionFailure(
                "Invalid URL components: \(components)"
            )
        }
        
        return url
    }
    
    public func constructURLRequest(for url: URL, httpMethod: HTTPMethod, header: [String:String] = [:]) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        for (key, value) in header {
            request.setValue(value, forHTTPHeaderField: key)
        }
        return request
    }
    
//    public func constructURLRequest<T: Codable>(for url: URL, httpMethod: HTTPMethod, header: [String:String] = [:], body: T) -> URLRequest {
//        var request = URLRequest(url: url)
//        request.httpMethod = httpMethod.rawValue
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        for (key, value) in header {
//            request.setValue(value, forHTTPHeaderField: key)
//        }
//        do {
//            let data = try JSONEncoder().encode(T.Type)
//        } catch {
//            print(error.localizedDescription)
//        }
//        return request
//    }
//
    public enum HTTPMethod: String {
        case GET, POST, PUT, DELETE
    }
}


