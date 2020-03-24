//
//  UserViewController.swift
//  Table-Research
//
//  Created by Ominext on 3/12/20.
//  Copyright © 2020 Ominext. All rights reserved.
//

import UIKit
import Alamofire
class UserViewController: UIViewController {
  
  private var listUsers :[UserEntity] = []
  
  let tableView:UITableView = {
    let table = UITableView()
    table.translatesAutoresizingMaskIntoConstraints = false
    return table
  
  }()
  var userPresenter:ViewToPresenterUserListProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
      print("Starting...")
      UserListRouter.createUsersListModule(userListRef: self)
      print("Start Fetching...")

      userPresenter?.fetchUsers()
      
      self.view.addSubview(tableView)
      tableView.estimatedRowHeight = 900

      tableView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
      tableView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
      tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
      tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
      tableView.register(UINib(nibName: "UsersTableViewCell", bundle: nil), forCellReuseIdentifier: "UsersTableViewCell")
//      tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

      tableView.dataSource = self
      tableView.delegate = self
      

        // Do any additional setup after loading the view.
    }
    

}

// -- Mark extenstion UserViewController
extension UserViewController:PresenterToViewUserListProtocol{
  func onPostResponseSucces(usersList: Array<UserEntity>) {
    self.listUsers = usersList
    
    DispatchQueue.main.async {
      self.tableView.reloadData()
    }
  }
  
  func onPostResponseFailed(error: String) {
    
    print(error)
  }
  
}

//- MARK UITableViewDataSource

extension UserViewController:UITableViewDataSource{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return listUsers.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "UsersTableViewCell", for: indexPath) as? UsersTableViewCell else {
      return UITableViewCell()
    }
    
    let user = listUsers[indexPath.row]
    Alamofire.request(user.avatar_url).responseData { (response) in
      if response.error == nil{
        print(response.result)
        if let data = response.data{
          DispatchQueue.main.async {
            cell.avatarImage.image = UIImage(data: data)
            cell.userNameLabel.text = user.login
            cell.scoreLabel.text = String(user.score)
//            cell.imageView!.image = UIImage(data: data)
//            cell.textLabel?.text = user.login

          }
        }
      }
    }
    
    return cell
  }
  
  
  
}
//MARK UITableViewDelegate
extension UserViewController:UITableViewDelegate{
  
  
}


