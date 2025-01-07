//
//  MockAPIManager.swift
//  TechTestTests
//
//  Created by Vivek on 26/12/24.
//

import Foundation
// This is only for testing purpose...
class MockApiManager: ApiManagerRequests {
    
    func getData<T: Decodable>(endPoint: String) async throws -> T {
        
        let url = Bundle.main.url(forResource: "Verses", withExtension: "json")
        let data = try Data(contentsOf: url!)
        let values = try JSONDecoder().decode(T.self, from: data)
        return values
    }
}
