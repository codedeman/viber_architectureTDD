//
//  UserListInteractor.swift
//  Table-Research
//
//  Created by Ominext on 3/12/20.
//  Copyright © 2020 Ominext. All rights reserved.
//

import Foundation
class UserListInteractor: PresenterToInteractorUserListProtocol {
  var presenter: InteractorToPresenterUserListPotocol?
  var userApiWorker:UserApiClient?
  var userService:UserService?
  
  required init(withApiWorker userApiWorker:UserApiClient) {
    self.userApiWorker = userApiWorker
  }

  func loadUser() {
    
//    userApiWorker?.fetchUser(callBack: { (userList,err ) in
//
//      self.presenter?.usersSuccess(userList: userList!)
//    })

    UserService.requestUserWithUsername(username: "kevin" , onSuccess: { (userList) in
      self.presenter?.usersSuccess(userList: userList!)
    }) { (error) in
      
      self.presenter?.userFailed(error: error)
    }
  }
  

  
  
}
