//
//  ProductViewModel.swift
//  ShiKe
//
//  Created by 沈永聪 on 2018/6/8.
//  Copyright © 2018年 沈永聪. All rights reserved.
//

import UIKit

class ProductViewModel: NSObject, ProductViewModelInterface {
    //MARK:- Members
    var delegate: ProductViewModelDelegate?
    var product: Product? {
        return _product
    }
    
    private var _product: Product?
    
    var coverStr: String? {
        return _product?.coverUrl
    }
    
    var titleStr: String? {
        return _product?.name
    }
    
    var priceStr: String? {
        return shike_localized("shike_money_prefix") + " " + String(_product!.price)
    }
    
    var typeStr: String? {
        return String(_product!.type)
    }
    
    //MARK:- Life cycle
    convenience init(_ product: Product?) {
        self.init()
        
        _product = product
    }
}
