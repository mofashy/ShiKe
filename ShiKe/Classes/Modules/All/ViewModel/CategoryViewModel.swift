//
//  CategoryViewModel.swift
//  ShiKe
//
//  Created by 沈永聪 on 2018/6/8.
//  Copyright © 2018年 沈永聪. All rights reserved.
//

import UIKit

class CategoryViewModel: NSObject {
    //MARK:- Members
    var titleStr: String? {
        return _category?.title
    }
    
    var detailStr: String? {
        return _category?.detail
    }
    
    var productList: Array<ProductViewModel>? {
        return _productList
    }
    
    var category: Category? {
        return _category
    }
    
    private var _productList: [ProductViewModel]?
    private var _category: Category?
    
    //MARK:- Life cycle
    convenience init(_ category: Category?) {
        self.init()
        
        self._category = category
        
        if let productList = category?.productList {
            self._productList = Array<ProductViewModel>()
            for product in productList {
                self._productList?.append(ProductViewModel(product))
            }
        }
    }
}
