//
//  ApiManager.swift
//  TechTest
//
//  Created by Vivek on 26/12/24.
//

import Foundation

//MARK: Enum for error scenarios in api calls.
public enum NetworkError: Error {
    case badURL
}

//MARK: Actual Endpoint with base and its extensions..
public enum ApiEndPoint: String {
    
    // Swagger https://gita-api.vercel.app/docs#/default/get_verse_serial__language__verse__verse_no_serial__get
    
    case baseUrl = "https://gita-api.vercel.app/tel/verse/" // replace tel with odi to get it in different language...
    case typeOfVerse = "1/1" // Can change here for different values...
    
}

//MARK: Generic functions for network manager..
protocol ApiManagerRequests {
    
    func getData<T: Decodable>(endPoint: String) async throws -> T
    
}

//MARK: This class is for actual endpoint call..
public class ApiManager: ApiManagerRequests {
    
    private let session = URLSession.shared
    private let decoder = JSONDecoder()
    
    //Generic  function to get data from server..
    func getData<T: Decodable>(endPoint: String) async throws -> T {
        
        guard let url = URL(string: endPoint) else { return NetworkError.badURL as! T }
        let (data, _) = try await session.data(from: url)
        return try decoder.decode(T.self, from: data)
    }
}
