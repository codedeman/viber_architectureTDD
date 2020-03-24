//
//  SingInProtocols.swift
//  Table-Research
//
//  Created by Ominext on 3/23/20.
//  Copyright © 2020 Ominext. All rights reserved.
//

import UIKit

protocol SignInPresentation {
  
  var  view:SignInView?{get set}
  var router:SignInRoutable! {get set}
  var interactor:SignInInteraction! {get set}
  
  func signIn(username:String)
  
}
protocol SignInView:class {
  var presenter:SignInPresentation! {get set}
  func updateLoading(loading:Bool) 
}

protocol SignInInteraction:class {
  var output:SignInInteractorOutput?{get set}
  func signIn(username:String)
//  var fetcher:
}
protocol SignInInteractorOutput {
  
  func success()
  func failed(error:Error)
}

protocol SignInRoutable:class {
  
  var viewController:UIViewController?{get set}
  func showAlert(for error:Error)
}
