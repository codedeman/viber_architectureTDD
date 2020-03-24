//
//  UsersTableViewCell.swift
//  Table-Research
//
//  Created by Ominext on 3/20/20.
//  Copyright © 2020 Ominext. All rights reserved.
//

import UIKit

class UsersTableViewCell: UITableViewCell {

  @IBOutlet var avatarImage: UIImageView!
  @IBOutlet var userNameLabel: UILabel!
  @IBOutlet var scoreLabel: UILabel!

  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
  
  func configureCell(user:UserEntity)  {
    
    guard let url = URL(string: user.avatar_url) else {return}
    DispatchQueue.global(qos: .background).async {
      
      do{
        guard let url = URL(string: user.avatar_url) else { return  }
        guard let data = try? Data(contentsOf: url) else {
          return
        }
        DispatchQueue.main.async {
          
          print("data \(data)")
//          if  data != nil{
//            self.avatarImage.image = UIImage(data: data)
//          }
        }
      }catch{
      }
    }

  }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
