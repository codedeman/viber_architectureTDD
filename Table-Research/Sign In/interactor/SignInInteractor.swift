//
//  SignInInteractor.swift
//  Table-Research
//
//  Created by Ominext on 3/23/20.
//  Copyright © 2020 Ominext. All rights reserved.
//

import UIKit

class SignInInteractor:SignInInteraction   {
  var output: SignInInteractorOutput?
  var fetcher:NetworkDataFetcher!
  func signIn(username: String) {
    
    let stripWhitespace = username.removeWhiteSpace()
    guard stripWhitespace.count > 0 else {
      output?.failed(error: SignInErrorCodes.empty)
      return
    }
    guard stripWhitespace.count < 20 else {
      output?.failed(error: SignInErrorCodes.tooLong)
      return
    }
    fetcher.response = self
    fetcher.start()
    
  }
  
  
  
}


extension SignInInteractor: NetworkDataFetcherResponse {
  
  func fetcherResponseSuccess() {
    output?.success()
  }
  
  func fetcherResponseFailed(error: Error) {
    output?.failed(error: error)
  }
}

extension String {
  
  func removeWhiteSpace() -> String {
    return replacingOccurrences(of: " ", with: "")
  }
}

enum SignInErrorCodes: Error {
  
  case empty
  case tooLong
}

protocol NetworkDataFetcher {
  
  var request: URLRequest! { get set }
  var response: NetworkDataFetcherResponse! { get set }
  func start()
}

protocol NetworkDataFetcherResponse {
  
  func fetcherResponseSuccess()
  func fetcherResponseFailed(error: Error)
}
