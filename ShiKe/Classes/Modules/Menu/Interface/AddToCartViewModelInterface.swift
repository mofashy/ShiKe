//
//  AddToCartViewModelInterface.swift
//  ShiKe
//
//  Created by 沈永聪 on 2018/6/12.
//  Copyright © 2018年 沈永聪. All rights reserved.
//

import Foundation

@objc protocol AddToCartViewModelDelegate {
    func reloadViews()
    func alertInfo()
    func reloadCart()
}

protocol AddToCartViewModelInterface {
    var delegate: AddToCartViewModelDelegate? { get set }
    
    func capacityDidChange(capacity: Capacity?)
    func temperatureDidChange(temperature: Temperature?)
    func sugarinessDidChange(sugariness: Sugariness?)
    func quantityDidIncrease()
    func quantityDidDecrease()
    
    
    func addToCart()
}
