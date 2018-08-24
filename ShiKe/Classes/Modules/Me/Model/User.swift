//
//  User.swift
//  ShiKe
//
//  Created by 沈永聪 on 2018/6/9.
//  Copyright © 2018年 沈永聪. All rights reserved.
//

import UIKit

enum Gender: String, Codable {
    case male = "m"
    case female = "f"
    case secret = "s"
}

class User: NSObject, Codable {
    //MARK:- Members
    var name: String?
    var gender: Gender?
    var birthday: Int?
    var address: String?
}
