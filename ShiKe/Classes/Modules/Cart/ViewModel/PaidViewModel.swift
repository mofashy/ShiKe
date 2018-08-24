//
//  PaidViewModel.swift
//  ShiKe
//
//  Created by 沈永聪 on 2018/6/13.
//  Copyright © 2018年 沈永聪. All rights reserved.
//

import UIKit

class PaidViewModel: NSObject, PaidViewModelInterface {
    //MARK:- Members
    var delegate: PaidViewModelDelegate?
    
    var productList: [CartProductViewModel]? {
        return _productList
    }
    
    var sum: String? {
        return shike_localized("shike_money_prefix") + " " + String(calcSum())
    }
    
    var discount: String? {
        //FIXME: 处理优惠券的使用，折扣等
        return "- " + shike_localized("shike_money_prefix") + " "
    }
    
    var actuallyPay: String? {
        //FIXME: 处理优惠券的使用，折扣等
        return shike_localized("shike_money_prefix") + " " + String(calcSum())
    }
    
    private var _productList: [CartProductViewModel]?
    
    func calcSum() -> Int {
        var sum = 0
        if let productVMs = productList {
            for productVM in productVMs {
                sum += productVM.price * productVM.quantity
            }
        }
        
        return sum
    }
    
    //MARK:- Life cycle
    convenience init(_ productList: [CartProductViewModel]?) {
        self.init()
        
        if let productList = productList {
            self._productList = [CartProductViewModel]()
            for product in productList where product.isCheck {
                self._productList?.append(product)
            }
        }
    }
}
