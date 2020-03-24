//
//  SignInInteractorTests.swift
//  Table-ResearchTests
//
//  Created by Ominext on 3/23/20.
//  Copyright © 2020 Ominext. All rights reserved.
//

import XCTest
@testable  import Table_Research
class SignInInteractorTests: XCTestCase {

  var sut:SignInInteractor?
  var mockOutput:MockSignInInteractorOutput?
  
    override func setUp() {
      sut = SignInInteractor()
      mockOutput = MockSignInInteractorOutput()
      sut?.fetcher = MockDataFetcher()
      sut?.output = mockOutput
      super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
      sut = nil
      mockOutput = nil
      super.tearDown()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
  
    func testFailsWithEmptyUsername() {
      sut?.signIn(username: "")
      XCTAssertFalse(mockOutput!.isSuccess)
      XCTAssertEqual(mockOutput!.error?.localizedDescription, SignInErrorCodes.empty.localizedDescription)
    }
  
    func testFailsWithOnlySpacesInUsername() {
      sut?.signIn(username: "    ")
      XCTAssertFalse(mockOutput!.isSuccess)
      XCTAssertEqual(mockOutput!.error?.localizedDescription, SignInErrorCodes.empty.localizedDescription)
    }
  
    func testFailsIfOver20CharacterLimit() {
      sut?.signIn(username: "test.verylongusernamewhichisoverthelimit")
      XCTAssertFalse(mockOutput!.isSuccess)
      XCTAssertEqual(mockOutput!.error?.localizedDescription, SignInErrorCodes.tooLong.localizedDescription)
    }
  
    func testPassesWithCorrectUsername() {
      sut?.signIn(username: "test.viper")
      XCTAssertTrue(mockOutput!.isSuccess)
      XCTAssertNil(mockOutput?.error)
    }
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}


class MockSignInInteractorOutput: SignInInteractorOutput {
  var isSuccess = false
  var error: Error?
  func success() {
    isSuccess = true
  }
  
  func failed(error: Error) {
    self.error = error
  }
  
}

class MockDataFetcher: NetworkDataFetcher {
  
  var response: NetworkDataFetcherResponse!
  var request: URLRequest!
  
  func start() {
    response.fetcherResponseSuccess()
  }
}
