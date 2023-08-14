//
//  _0230811_ZhanSalgarin_NYCSchoolsTests.swift
//  20230811-ZhanSalgarin-NYCSchoolsTests
//
//  Created by zhanybek salgarin on 8/14/23.
//

import XCTest
@testable import _0230811_ZhanSalgarin_NYCSchools

final class MainTests: XCTestCase {
    // Systen under test
    var sut: MainViewModelProtocol!
    
    override func setUpWithError() throws {
        let schoolService = MockSchoolDataService()
        schoolService.dbn = "abc"
        sut = MainViewModel(schoolDataService: schoolService)
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testFetchDataIsNotEmpty() {
        let expectation = expectation(description: "Fetch school data")
        sut.didDataLoad = {
            expectation.fulfill()
        }
        sut.fetchData()
        waitForExpectations(timeout: 3)
        XCTAssertFalse(self.sut.schools.isEmpty)
    }
    
    func testFetchDataDBNName() {
        let expectation = expectation(description: "Fetch school data")
        sut.didDataLoad = {
            expectation.fulfill()
        }
        sut.fetchData()
        waitForExpectations(timeout: 3)
        XCTAssertEqual(self.sut.schools.first?.dbn, "abc")
    }

}

