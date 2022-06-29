//
//  File.swift
//  
//
//  Created by Azhagusundaram Tamil on 29/06/22.
//

import Foundation

/// The type to which all operations must conform in order to execute and cancel a request.
protocol OperationProtocol {
    associatedtype Output

    /// The request to be executed.
    var request: RequestProtocol { get }

    /// Execute a request using a request dispatcher.
    /// - Parameters:
    ///   - requestDispatcher: `RequestDispatcherProtocol` object that will execute the request.
    ///   - completion: Completion block.
    func execute(in requestDispatcher: RequestDispatcherProtocol, completion: @escaping (Output) -> Void) ->  Void

    /// Cancel the operation.
    func cancel() -> Void
}
