//
//  CartViewModelInterface.swift
//  ShiKe
//
//  Created by 沈永聪 on 2018/6/13.
//  Copyright © 2018年 沈永聪. All rights reserved.
//

import Foundation

@objc protocol CartViewModelDelegate {
    func reloadCart()
    func reloadCells()
    func alertCartInfo()
}

protocol CartViewModelInterface {
    var delegate: CartViewModelDelegate? { get set }
    var productList: [CartProductViewModel]? { get }
    
    func checkboxDidChecked(_ isChecked: Bool)
    func addProduct(product: CartProductViewModel?)
    func removeProduct(at index: Int)
    func pay()
}
