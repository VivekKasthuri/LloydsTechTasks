//
//  TechTestTests.swift
//  TechTestTests
//
//  Created by Vivek on 26/12/24.
//

import XCTest
@testable import TechTest

@MainActor
final class TechTestTests: XCTestCase {
   
    func testGetData() async throws {
        let sut =  LandingViewModel()
        let task = await sut.getVerseDetails()
        let details = try await task.value
        XCTAssertNotNil(details)
        XCTAssertEqual(details.chapter_no, 1)
    }

    func testStubVerseDetails() async throws {
        let sut =  LandingViewModel()
        let url = Bundle.main.url(forResource: "Verses", withExtension: "json")
        do {
            let data = try Data(contentsOf: url!)
            let values = try JSONDecoder().decode(BookDetails.self, from: data)
            sut.details = values
            XCTAssertNotNil(sut.details)
            XCTAssertNotEqual(sut.details?.chapter_no, 1)
        } catch {
            XCTFail("Not able to parse")
            
        }
    }
    
    func testCompareData() async throws {
        let sut =  LandingViewModel()
        var expectedValues: BookDetails?
        var resultedValues: BookDetails?
        let task = await sut.getVerseDetails()
        if let verses = try? await task.value {
            resultedValues = verses
        }
        let url = Bundle.main.url(forResource: "Verses", withExtension: "json")
        do {
            let data = try Data(contentsOf: url!)
            expectedValues = try JSONDecoder().decode(BookDetails.self, from: data)
        }
        XCTAssertNotNil(resultedValues)
        XCTAssertNotEqual(resultedValues?.chapter_no, expectedValues?.chapter_no)
    }
    
    func testMockApiManagerData() async throws {
        let sut =  LandingViewModel(manager: MockApiManager())
        let task = await sut.getVerseDetails()
        let details = try await task.value
        XCTAssertNotNil(details)
        XCTAssertNotEqual(details.chapter_no, 1)
    }

}
