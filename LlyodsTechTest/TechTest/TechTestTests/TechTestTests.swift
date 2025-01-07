//
//  TechTestTests.swift
//  TechTestTests
//
//  Created by Vivek on 26/12/24.
//

import XCTest
@testable import TechTest
//MARK: These tests will cover all files CC: is 100%...
@MainActor
final class TechTestTests: XCTestCase { 
    
    func testGetData() async throws {
        
        let sut =  LandingViewModel()
        let task = await sut.getVerseDetails()
        let details = try await task.value
        XCTAssertNotNil(details)
        XCTAssertEqual(details.chapter_no, 1)
    }
    
    // This test case is for stub...
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
    
    // Comparing actual data and stub data....
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
        XCTAssertNotEqual(resultedValues?.verse, expectedValues?.verse)
    }
    
    // MockApi manager mock data....
    func testMockApiManagerData() async throws {
        
        let sut =  LandingViewModel(manager: MockApiManager())
        let task = await sut.getVerseDetails()
        let details = try await task.value
        XCTAssertNotNil(details)
        XCTAssertNotEqual(details.chapter_no, 1)
        XCTAssertNotEqual(details.verse, "Krishna and Arjuna")
    }
    
    // Comparing actual and mock data....
    func testCompareMockData() async throws {
        
        let sut =  LandingViewModel()
        let task = await sut.getVerseDetails()
        let details = try await task.value
        let mockSut =  LandingViewModel(manager: MockApiManager())
        let mockTask = await mockSut.getVerseDetails()
        let mockdetails = try await mockTask.value
        XCTAssertNotNil(details)
        XCTAssertNotNil(mockdetails)
        XCTAssertNotEqual(details.chapter_no, mockdetails.chapter_no)
        XCTAssertNotEqual(details.verse, mockdetails.verse)
    }
    
    //MARK: Below test cases with cover the file structure "BookDetails"...
    func testCompareMockDataWithMockStructure() async throws {
        
        let sut = BookDetails(chapter_no: 2, verse_no: 3, language: "odi", chapter_name: "one", verse: "two", transliteration: "no", synonyms: "synonyms", audio_link: "http//:example.com", translation: "no", purport: ["one","two"])
        let mockSut =  LandingViewModel(manager: MockApiManager())
        let mockTask = await mockSut.getVerseDetails()
        let mockdetails = try await mockTask.value
        XCTAssertNotNil(sut)
        XCTAssertNotNil(mockdetails)
        XCTAssertEqual(sut.chapter_no, mockdetails.chapter_no)
        XCTAssertNotEqual(sut.verse, mockdetails.verse)
    }
    
    func testCompareActualDataWithMockStructure() async throws {
        
        let sut =  LandingViewModel()
        let task = await sut.getVerseDetails()
        let details = try await task.value
        let mockSut = BookDetails(chapter_no: 2, verse_no: 3, language: "odi", chapter_name: "one", verse: "two", transliteration: "no", synonyms: "synonyms", audio_link: "http//:example.com", translation: "no", purport: ["one","two"])
        XCTAssertNotNil(details)
        XCTAssertNotEqual(details.chapter_no, mockSut.chapter_no)
        XCTAssertNotEqual(details.verse, mockSut.verse)
    }
}
