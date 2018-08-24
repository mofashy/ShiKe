//
//  UserViewModel.swift
//  ShiKe
//
//  Created by 沈永聪 on 2018/6/9.
//  Copyright © 2018年 沈永聪. All rights reserved.
//

import UIKit

class UserViewModel: NSObject {
    //MARK:- Members
    var nameStr: String? {
        return _user?.name
    }
    
    var genderStr: String? {
        return _gender
    }
    
    var ageStr: String? {
        return _age
    }
    
    var addressStr: String? {
        return _user?.address
    }
    
    private var _user: User?
    private var _age: String?
    private var _gender: String?
    
    convenience init(_ user: User) {
        self.init()
        
        _user = user
        
        if let gender = user.gender {
            switch gender {
            case .male:
                _gender = "男"
            case .female:
                _gender = "女"
            case .secret:
                _gender = "保密"
            }
        }
        
        let date = Date(timeIntervalSince1970: TimeInterval(user.birthday!))
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year], from: date)
        if let year = components.year {
            _age = String(year)
        }
    }
}
