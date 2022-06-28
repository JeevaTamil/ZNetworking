//
//  File.swift
//  
//
//  Created by Azhagusundaram Tamil on 27/06/22.
//

import Foundation
import Combine

@available(macOS 10.15, *)
public class ZAPIManager {
    public static var shared = ZAPIManager()
    private var subscriber = Set<AnyCancellable>()
    private var session = URLSession.shared
    
    public func fetch<T: Decodable>(url: URL, completion: @escaping (Result<T, Error>) -> Void)  {
        // 1. Create 'dataTaskPusblisher'(Publisher) to make the API call
        session.dataTaskPublisher(for: url)
            // 2. Use 'map'(Operator) to get the data from the result
            .map { $0.data }
            // 3. Decode the data into the 'Decodable' struct using JSONDecoder
            .decode(type: NetworkResponse<T>.self, decoder: JSONDecoder())
            // 4. Make this process in main thread. (you can do this in background thread as well)
            .receive(on: DispatchQueue.main)
            // 5. Use 'sink'(Subcriber) to get the decoaded value or error, and pass it to completion handler
            .sink { (resultCompletion) in
                switch resultCompletion {
                case .failure(let error):
                    completion(.failure(error))
                case .finished:
                    return
                }
            } receiveValue: { (result) in
                completion(.success(result.result))
            }
            // 6. saving the subscriber into an AnyCancellable Set (without this step this won't work)
            .store(in: &subscriber)
    }
    
    public func fetch<T: Codable>(request: URLRequest, completion: @escaping (Result<T, Error>) -> Void) {
        session.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: NetworkResponse<T>.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { (resultCompletion) in
                switch resultCompletion {
                case .failure(let error):
                    completion(.failure(error))
                case .finished:
                    return
                }
            } receiveValue: { (result) in
                completion(.success(result.result))
            }
            .store(in: &subscriber)
    }
}
