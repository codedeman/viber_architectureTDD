//
//  SignInPresenterTest.swift
//  Table-ResearchTests
//
//  Created by Ominext on 3/23/20.
//  Copyright © 2020 Ominext. All rights reserved.
//

import XCTest

@testable import Table_Research;
class SignInPresenterTest: XCTestCase {

  var sut:SignInPresenter?
  var mockView:MockSignInView?
  var mockInteractor:MockSignInInteractor?
  var mockRouter:MockSignInRouter?
  
    override func setUp() {
      sut = SignInPresenter()
      mockView = MockSignInView()
      mockInteractor = MockSignInInteractor()
      mockRouter = MockSignInRouter()
      mockInteractor?.output = sut
      sut?.view = mockView
      sut?.interactor = mockInteractor
      sut?.router = mockRouter
      super.setUp()
    }

    override func tearDown() {
      sut = nil
      mockView = nil
      mockInteractor = nil
      super.tearDown()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
  
  func testViewLoadingStateChangesWhenSignIn()  {
    
    mockInteractor?.noReturn = true
    sut?.signIn(username: "")
    XCTAssert(mockView?.loading ?? false)
  }
  
  func testInteractorStartsSignInProcess()  {
    sut?.signIn(username: "")
    XCTAssert(mockInteractor?.processing ?? false)
    
  }
  
  func testUpdatesViewWhenSuccessIsReturned()
  {
    mockInteractor?.fail = true
    sut?.signIn(username: "")
    XCTAssertFalse(mockView?.loading ?? true)
  }
  
  func testWhenFailure()  {
    
    mockInteractor?.fail = true
    sut?.signIn(username: "")
    XCTAssertTrue(mockRouter?.showAlert ?? false)
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


class MockSignInView: SignInView {
  
  var loading = false
  var presenter: SignInPresentation!
  
  func updateLoading(loading: Bool) {
    self.loading = loading
  }
}



class MockSignInInteractor: SignInInteraction {
  
  var processing = false
  var fail = false
  var noReturn = false
  var output: SignInInteractorOutput?
  var fetcher: NetworkDataFetcher! = MockDataFetcher()
  
  func signIn(username: String) {
    self.processing = true
    guard !noReturn else { return }
    if fail {
      output?.failed(error: SignInErrorCodes.empty)
    } else {
      output?.success()
    }
  }
}

class  MockSignInRouter: SignInRoutable {
  var viewController: UIViewController?
  var showAlert = false
  
  func showAlert(for error: Error) {
    showAlert = true
  }
  
  
}
