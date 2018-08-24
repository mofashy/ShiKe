//
//  CartPay.swift
//  ShiKe
//
//  Created by 沈永聪 on 2018/6/9.
//  Copyright © 2018年 沈永聪. All rights reserved.
//

import UIKit

/** 支付状态 */
enum State: Int, Codable {
    case prepare = 0
    case waiting = 1
    case finish = 2
    case cancel = 3
}

class CartPay: NSObject, Codable {
    //MARK:- Members
    var price: Int = 0
    var state: State?
    var date: TimeInterval?
    var productList: Array<CartProduct>?
}
