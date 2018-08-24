//
//  Coupon.swift
//  ShiKe
//
//  Created by 沈永聪 on 2018/6/10.
//  Copyright © 2018年 沈永聪. All rights reserved.
//

import UIKit

enum CouponState: Int, Codable {
    case unused = 1
    case used = 2
    case expired = 3
}

class Coupon: NSObject, Codable {
    //MARK:- Members
    var money: Int?
    var name: String?
    var valid: TimeInterval?
    var state: CouponState?
    
    enum CodingKeys: String, CodingKey {
        case money
        case name
        case valid
        case state
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        money = try container.decode(Int.self, forKey: .money)
        name = try container.decode(String.self, forKey: .name)
        valid = try container.decode(TimeInterval.self, forKey: .valid)
        state = try container.decode(CouponState.self, forKey: .state)
    }
    
    func encode(to encoder: Encoder) throws {
        //FIXME: 处理模型转json
    }
}
