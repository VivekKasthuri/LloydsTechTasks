//
//  LandingViewModel.swift
//  TechTest
//

import Foundation
import SwiftUI

// MARK:  functions to get the data from Network manager..
protocol LandingViewRequests {
    
    func getVerseDetails() async -> Task<BookDetails, Error>
}

// MARK: Viewmodel where actual business logic exists..
class LandingViewModel: ObservableObject, LandingViewRequests {
    
    @Published var details: BookDetails?
    private var manager: ApiManagerRequests?
    init(manager: ApiManagerRequests = ApiManager()) {
        self.manager = manager
    }
    
    // Get the values from api call...
    func getVerseDetails() async -> Task<BookDetails, Error> {
        
        return Task {
            guard let details: BookDetails = try await manager?.getData(endPoint: ApiEndPoint.baseUrl.rawValue + ApiEndPoint.typeOfVerse.rawValue) else { return self.details! }
            return details
        }
    }
}
