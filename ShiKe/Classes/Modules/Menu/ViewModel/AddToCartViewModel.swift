//
//  AddToCartViewModel.swift
//  ShiKe
//
//  Created by 沈永聪 on 2018/6/12.
//  Copyright © 2018年 沈永聪. All rights reserved.
//

import UIKit

class AddToCartViewModel: NSObject, AddToCartViewModelInterface {
    weak var delegate: AddToCartViewModelDelegate?
    
    private var product: Product?
    private var capacity: Capacity?
    private var temperature: Temperature?
    private var sugariness: Sugariness?
    private var _quantity = 1
    
    var quantity: Int {
        return _quantity
    }
    
    var titleStr: String? {
        return product?.name
    }
    
    var priceStr: String? {
        return shike_localized("shike_money_prefix") + " " + String(product!.price)
    }
    
    convenience init(_ product: Product?) {
        self.init()
        
        self.product = product
    }
    
    func capacityDidChange(capacity: Capacity?) {
        self.capacity = capacity
    }
    
    func temperatureDidChange(temperature: Temperature?) {
        self.temperature = temperature
    }
    
    func sugarinessDidChange(sugariness: Sugariness?) {
        self.sugariness = sugariness
    }
    
    func quantityDidIncrease() {
        _quantity += 1
        delegate?.reloadViews()
    }
    
    func quantityDidDecrease() {
        if _quantity == 1 {
            delegate?.alertInfo()
            return
        }
        _quantity -= 1
        delegate?.reloadViews()
    }
    
    func addToCart() {
        let carProduct = CartProduct()
        carProduct.coverUrl = product?.coverUrl
        carProduct.name = product?.name
        carProduct.price = product!.price
        carProduct.quantity = _quantity
        carProduct.capacity = capacity ?? .tall
        carProduct.temperature = temperature ?? .less
        carProduct.sugariness = sugariness ?? .less
        carProduct.isCheck = true
        
        let result = TableManager.shared.insertTable(carProduct)
        if result {
            delegate?.reloadCart()
        }
    }
}
