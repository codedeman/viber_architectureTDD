//
//  SignInRouter.swift
//  Table-Research
//
//  Created by Ominext on 3/23/20.
//  Copyright © 2020 Ominext. All rights reserved.
//

import Foundation
import UIKit
class SignInRouter: SignInRoutable {
  var viewController: UIViewController?
  
  
  class func create() -> UIViewController {
    let signInVC = SignInViewController()
    
    let presenter = SignInPresenter()
    let router = SignInRouter()
    router.viewController = signInVC
    
    let interactor = SignInInteractor()
    interactor.output = presenter
    presenter.view = signInVC
    presenter.router = router
    presenter.interactor = interactor
    signInVC.presenter = presenter
    
    return signInVC
  }
  func showAlert(for error: Error) {
    let alert = UIAlertController(title: nil, message: error.localizedDescription, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
    viewController?.present(alert, animated: true, completion: nil)
  }
  
  
  
}
