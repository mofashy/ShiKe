//
//  CouponViewModel.swift
//  ShiKe
//
//  Created by 沈永聪 on 2018/6/10.
//  Copyright © 2018年 沈永聪. All rights reserved.
//

import UIKit

class CouponViewModel: NSObject {
    //MARK:- Members
    var moneyStr: String? {
        return String(_coupon!.money!)
    }
    
    var titleStr: String? {
        return _coupon?.name
    }
    
    var validStr: String? {
        return _valid
    }
    
    var state: CouponState? {
        return _coupon?.state
    }
    
    private var _coupon: Coupon?
    private var _valid: String?

    //MARK:- Life cycle
    convenience init(_ coupon: Coupon) {
        self.init()
        
        _coupon = coupon
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        _valid = shike_localized("shike_valid_prefix") + dateFormatter.string(from: Date(timeIntervalSince1970: coupon.valid!))
    }
}
