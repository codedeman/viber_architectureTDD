//
//  SignInViewController.swift
//  Table-Research
//
//  Created by Ominext on 3/23/20.
//  Copyright © 2020 Ominext. All rights reserved.
//

import UIKit
import SnapKit
class SignInViewController: UIViewController {

  var presenter: SignInPresentation!

  let emailTxt:UITextField = {
    let txt = UITextField()
    txt.borderStyle = .roundedRect
//    txt.backgroundColor =
    txt.placeholder = "Email Adress"
    return txt
  
  }()
  let activityIndicatorView:UIActivityIndicatorView = {
    let activity = UIActivityIndicatorView()
    activity.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.2156862745, blue: 0.02352941176, alpha: 1)
    return activity
  }()
  
  let passWorldTxt:UITextField = {
    let txt = UITextField()
    txt.borderStyle = .roundedRect
    txt.placeholder = "PassWorld"
    return txt
  }()
  let mainView:UIView = {
    let view = UIView()
    view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    view.alpha = 0.8
    return view
  }()
  let imageBackGround:UIImageView = {
    let image = UIImageView()
    image.translatesAutoresizingMaskIntoConstraints = false
    image.image = UIImage(named: "food.jpg" )
    return image
  }()
  
  let loginButton:UIButton = {
    let btn = UIButton()
    btn.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
    btn.tintColor = .white
    btn.setTitle("Sign In", for: .normal)
    
    return btn
  }()
    override func viewDidLoad() {
        super.viewDidLoad()
//      loginButton.setTitle("Login", for: .a)
      self.view.addSubview(imageBackGround)
      imageBackGround.addSubview(mainView)
      view.addSubview(emailTxt)
      view.addSubview(loginButton)
      view.addSubview(passWorldTxt)
      mainView.addSubview(activityIndicatorView)
      imageBackGround.snp.makeConstraints { (make) in
        make.leading.equalTo(self.view).inset(0)
        make.top.equalTo(self.view).inset(0)
        make.bottom.equalTo(self.view).inset(0)
        make.trailing.equalTo(self.view).inset(0)
      }
      
      mainView.snp.makeConstraints { (make) in
        make.leading.equalTo(self.imageBackGround).inset(0)
        make.top.equalTo(self.imageBackGround).inset(0)
        make.bottom.equalTo(self.imageBackGround).inset(0)
        make.trailing.equalTo(self.imageBackGround).inset(0)
      
      }
      
      emailTxt.snp.makeConstraints { (make) in
        
        make.centerX.equalTo(self.view)
        make.top.equalTo(self.view).inset(100)
        make.width.equalTo(200)
        make.height.equalTo(40)
//        make.leading.equalTo(self.view).inset(10)
//        make.trailing.equalTo(self.view).inset(-10)
        
      }
      
      passWorldTxt.snp.makeConstraints { (make) in
        make.centerX.equalTo(self.view)
        make.top.equalTo(self.emailTxt).inset(50)
        make.width.equalTo(200)
        make.height.equalTo(40)
//        make.leading.equalTo(self.view).inset(10)
//        make.trailing.equalTo(self.view).inset(-10)
        
      }
      
      loginButton.snp.makeConstraints { (make) in
        make.centerX.equalTo(self.view)
        make.top.equalTo(self.emailTxt).inset(100)
        make.leading.equalTo(self.view).inset(10)
        make.trailing.equalTo(self.view).inset(-10)
        
      }
      activityIndicatorView.snp.makeConstraints { (make) in
        
        make.centerX.equalTo(self.view)
        make.centerY.equalTo(self.view)
      }
      
      
    
      
      loginButton.addTarget(self, action: #selector(loginButtonWasPressed), for: .allEvents)
      
      

//      imageBackGround.leadingAnchor.constraint(equalTo: self.view, constant: 0).isActive
      
    }
  
  @objc func loginButtonWasPressed(){
    
    print("login button was click" )
  }
    

  

}

extension SignInViewController:SignInView{
  
  
  func updateLoading(loading: Bool) {
    
      loginButton.isUserInteractionEnabled = loading
      loading ? activityIndicatorView.startAnimating() : activityIndicatorView.stopAnimating()
  }
  
  
  
}
