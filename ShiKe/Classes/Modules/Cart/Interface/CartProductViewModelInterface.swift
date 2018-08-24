//
//  CartProductViewModelInterface.swift
//  ShiKe
//
//  Created by 沈永聪 on 2018/6/13.
//  Copyright © 2018年 沈永聪. All rights reserved.
//

import Foundation

@objc protocol CartProductViewModelDelegate {
    func reloadCell(_ cell: CartProductCell?)
    func alertInfo()
    func removeFromCart()
}

protocol CartProductViewModelInterface {
    var delegate: CartProductViewModelDelegate? { get set }
    var cell: CartProductCell? { get set }
    
    func checkboxDidChecked(_ isChecked: Bool)
    func quantityDidIncrease()
    func quantityDidDecrease()
    
    func removeFromCart()
}
