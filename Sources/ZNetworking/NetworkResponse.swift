//
//  File.swift
//  
//
//  Created by Azhagusundaram Tamil on 28/06/22.
//

import Foundation

struct NetworkResponse<Wrapped: Decodable>: Decodable {
    var result: Wrapped
}
