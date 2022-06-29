//
//  File.swift
//  
//
//  Created by Azhagusundaram Tamil on 28/06/22.
//

import Foundation

/// Enum of API Errors
public enum APIError: Error {
    /// Encoding issue when trying to send data.
    case encodingError(String?)
    /// No data recieved from the server.
    case noData
    /// The server response was invalid (unexpected format).
    case invalidResponse
    /// The request was rejected: 400-499
    case badRequest(String?)
    /// Encountered a server error.
    case serverError(String?)
    /// There was an error parsing the data.
    case parseError(String?)
    /// Unknown error.
    case unknown
}
