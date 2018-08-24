//
//  CartPayViewModel.swift
//  ShiKe
//
//  Created by 沈永聪 on 2018/6/9.
//  Copyright © 2018年 沈永聪. All rights reserved.
//

import UIKit

class CartPayViewModel: NSObject {
    //MARK: Members
    var priceStr: String = ""
    var state: State = .no
    var dateStr: String = ""
    var productList: Array<CartProductViewModel>?
    
    convenience init(_ productList: [CartProductViewModel]?) {
        self.init()
        
        self.productList = productList
    }
//    convenience init(_ pay: CartPay) {
//        self.init()
    
//        self.priceStr = NSLocalizedString("shike_money_prefix", comment: "$") + " " + String(pay.price)
//        self.state = pay.state ?? .no
////        self.date =
//        if let products = pay.productList {
//            productList = Array<CartProductViewModel>()
//            for product in products {
//                productList?.append(CartProductViewModel(product))
//            }
//        }
//    }
}
