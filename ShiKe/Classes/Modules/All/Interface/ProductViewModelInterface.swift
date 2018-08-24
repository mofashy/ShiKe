//
//  ProductViewModelInterface.swift
//  ShiKe
//
//  Created by 沈永聪 on 2018/6/12.
//  Copyright © 2018年 沈永聪. All rights reserved.
//

import Foundation

@objc protocol ProductViewModelDelegate {
    func reloadViews()
    func alertInfo()
}

protocol ProductViewModelInterface {
    var delegate: ProductViewModelDelegate? { get set }
    var product: Product? { get }
}
