//
//  ApiManager.swift
//  TechTest
//
//  Created by Vivek on 26/12/24.
//

import Foundation

public enum NetworkError: Error {
    case badURL
}

public enum ApiEndPoint: String {
    
    // Swagger https://gita-api.vercel.app/docs#/default/get_verse_serial__language__verse__verse_no_serial__get
    
    case baseUrl = "https://gita-api.vercel.app/tel/verse/"
    case typeOfVerse = "1/1" // Can change here for different values...
    
}

protocol ApiManagerRequests {
    func getData<T: Decodable>(endPoint: String) async throws -> T
    
}

public class ApiManager: ApiManagerRequests {
    
    private let session = URLSession.shared
    private let decoder = JSONDecoder()
    
    func getData<T: Decodable>(endPoint: String) async throws -> T {
        guard let url = URL(string: endPoint) else { return NetworkError.badURL as! T}
        let (data, _) = try await session.data(from: url)
        return try decoder.decode(T.self, from: data)
    }
}
