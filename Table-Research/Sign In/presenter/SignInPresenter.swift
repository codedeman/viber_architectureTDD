//
//  SignInPresenter.swift
//  Table-Research
//
//  Created by Ominext on 3/23/20.
//  Copyright © 2020 Ominext. All rights reserved.
//

import UIKit

class SignInPresenter: SignInPresentation {
  weak var view: SignInView?
  
  var router: SignInRoutable!
  
  var interactor: SignInInteraction!
  
  func signIn(username: String) {
    view?.updateLoading(loading: true)
    interactor.signIn(username: username)
  }
  
  
 
  
}

extension SignInPresenter:SignInInteractorOutput{
  func success() {
    view?.updateLoading(loading: false)
  }
  
  func failed(error: Error) {
    view?.updateLoading(loading: false)
    router.showAlert(for: error)
  }
  
  
  
}
