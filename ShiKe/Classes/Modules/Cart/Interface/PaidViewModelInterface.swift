//
//  PaidViewModelInterface.swift
//  ShiKe
//
//  Created by 沈永聪 on 2018/6/13.
//  Copyright © 2018年 沈永聪. All rights reserved.
//

import Foundation

@objc protocol PaidViewModelDelegate {
    
}

protocol PaidViewModelInterface {
    var delegate: PaidViewModelDelegate? { get set }
    var productList: [CartProductViewModel]? { get }
    
    var sum: String? { get }
    var discount: String? { get }
    var actuallyPay: String? { get }
}
