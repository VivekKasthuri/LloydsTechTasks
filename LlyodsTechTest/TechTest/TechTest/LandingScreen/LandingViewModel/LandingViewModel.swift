//
//  LandingViewModel.swift
//  TechTest
//

import Foundation
import SwiftUI

protocol LandingViewRequests {
    
    func getVerseDetails()async -> Task<BookDetails, Error>
}

@MainActor class LandingViewModel: ObservableObject, LandingViewRequests {
    
    @Published var details: BookDetails?
    private var manager: ApiManagerRequests?
    
    init(manager: ApiManagerRequests = ApiManager()) {
        self.manager = manager
    }
    
    func getVerseDetails()async -> Task<BookDetails, Error> {
        return Task {
            guard let details: BookDetails = try await manager?.getData(endPoint: ApiEndPoint.baseUrl.rawValue + ApiEndPoint.typeOfVerse.rawValue) else {return self.details!}
            return details
        }
    }

}
