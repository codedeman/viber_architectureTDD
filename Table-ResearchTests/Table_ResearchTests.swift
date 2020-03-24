//
//  Table_ResearchTests.swift
//  Table-ResearchTests
//
//  Created by Ominext on 3/12/20.
//  Copyright © 2020 Ominext. All rights reserved.
//

import XCTest
import Alamofire
import SwiftyJSON
import ObjectMapper
@testable import Table_Research

class Table_ResearchTests: XCTestCase {
  
  var sut:UserListInteractor?
  var interactor:MockUserInteractor?
  var service:MockDataService?

  
    override func setUp() {
      sut?.userApiWorker = MockDataFetcher() as! UserApiClient
      super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
  func testInteractor() {
    var userList1:[UserEntity]?

    UserService.requestUserWithUsername(username: "kevin" , onSuccess: { (userList) in
        userList1 = userList
        print("user list \(userList)")

    }) { (error) in
      debugPrint("error domain \(error)")
      
    }
//    for user in userList!{
//
//      XCTAssertEqual(user.login,"kevin")
//    }
  }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

class MockUserInteractor: InteractorToPresenterUserListPotocol {
  var error: Error?
  var userApiWorker:UserApiClient?

  func userFailed(error: Error) {
    self.error = error
  }
  var userList1:[UserEntity]?
  let path = Bundle.main.path(forResource: "GetUserSuccess", ofType: "json")

  func usersSuccess(userList: Array<UserEntity>) {
    UserService.requestUserWithUsername(username: "kevin", onSuccess: { (useList) in
      
      self.userList1 = userList
    
    }, onError: nil)
    print(userList)
  }
  

  
  
  
}


class MockDataService: UserApiClient {
  var userList1:[UserEntity]?
  
  
  static func requestUserWithUsername(username: String, onSuccess: UserCallback?, onError: ErrorCallback?) {
    
    Alamofire.request(ApiBaseURl+"\(username)").responseJSON { (response) in
      
      switch response.result{
        
      case .success(_):
        
        do{
          
          DispatchQueue.global(qos: .background).async {
            
            let data = response.data
            let json = try? JSON(data!)
            let arrayResponse = json?["items"].arrayObject
            
            let arrayObject = Mapper<UserEntity>().mapArray(JSONArray: arrayResponse as! [[String : Any]])
            print("dkdk \(arrayObject)")
            onSuccess!(arrayObject)
          }
          break
          
        }catch{
          debugPrint(error.localizedDescription)
        }
      case .failure(let err):
        onError?(err as NSError)
        break
      default: break
        //        onError()
        
      }
      
    }
  }
  
  //    func fetchUser(callBack: @escaping ([UserEntity]?, Error?) -> Void) {
  //
  //    }
  
  
}
