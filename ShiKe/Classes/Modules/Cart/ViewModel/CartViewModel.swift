//
//  CartViewModel.swift
//  ShiKe
//
//  Created by 沈永聪 on 2018/6/13.
//  Copyright © 2018年 沈永聪. All rights reserved.
//

import UIKit

class CartViewModel: NSObject, CartViewModelInterface {
    weak var delegate: CartViewModelDelegate?
    
    var productList: [CartProductViewModel]? {
        return _productList
    }
    
    private var _productList: [CartProductViewModel]?
    
    var isCheck: Bool {
        guard let productVMs = productList else {
            return false
        }
        
        for productVM in productVMs {
            if !productVM.isCheck {
                return false
            }
        }
        
        return true
    }
    
    var totalStr: String? {
        var sum = 0
        if let productVMs = productList {
            for productVM in productVMs where productVM.isCheck {
                sum += productVM.price * productVM.quantity
            }
        }
        
        return shike_localized("shike_money_prefix") + " " + String(sum)
    }
    
    func checkboxDidChecked(_ isChecked: Bool) {
        guard let productVMs = productList else {
            return
        }
        
        for productVM in productVMs {
            productVM.checkboxDidChecked(isChecked)
        }
        
        delegate?.reloadCart()
        delegate?.reloadCells()
    }
    
    func addProduct(product: CartProductViewModel?) {
        if let product = product {
            _productList?.append(product)
        }
    }
    
    func removeProduct(at index: Int) {
        _productList?.remove(at: index)
    }
    
    func pay() {
        
    }
    
    convenience init(_ productList: [CartProductViewModel]?) {
        self.init()
        
        self._productList = productList
    }
    
    override init() {
        super.init()
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadCart(_:)), name: NSNotification.Name(rawValue: ShiKeCartProductsChangedNotification), object: nil)
    }
    
    @objc func reloadCart(_ noti: Notification) {
        delegate?.reloadCart()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}
