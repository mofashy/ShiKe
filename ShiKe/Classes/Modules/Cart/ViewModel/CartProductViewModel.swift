//
//  CartProductViewModel.swift
//  ShiKe
//
//  Created by 沈永聪 on 2018/6/9.
//  Copyright © 2018年 沈永聪. All rights reserved.
//

import UIKit

private var shike_quantity_contenxt = 0
private var shike_checkbox_contenxt = 0

class CartProductViewModel: NSObject, CartProductViewModelInterface {
    weak var delegate: CartProductViewModelDelegate?
    weak var cell: CartProductCell?
    
    func checkboxDidChecked(_ isChecked: Bool) {
        product!.isCheck = isChecked
        
        updateCartProduct()
    }
    
    func quantityDidIncrease() {
        if let quantitty = product?.quantity {
            product!.quantity = quantitty + 1
        }
        
        updateCartProduct()
    }
    
    func quantityDidDecrease() {
        if let quantitty = product?.quantity {
            product!.quantity = max(1, quantitty - 1)
        }
        
        updateCartProduct()
    }
    
    func removeFromCart() {
        let result = TableManager.shared.deleteTable(_product)
        if result {
            delegate?.removeFromCart()
            NotificationCenter.default.post(name: Notification.Name(rawValue: ShiKeCartProductsChangedNotification), object: nil)
        }
    }
    
    private func updateCartProduct() {
        if TableManager.shared.updateTable(_product) {
        delegate?.reloadCell(cell)
        NotificationCenter.default.post(name: Notification.Name(rawValue: ShiKeCartProductsChangedNotification), object: nil)
        }
    }
    
    //MARK:- Members
    var isCheck: Bool {
        return product!.isCheck
    }
    
    var titleStr: String? {
        return product!.name
    }
    
    var detailStr: String? {
        return _detail
    }
    
    var priceStr: String? {
        return shike_localized("shike_money_prefix") + " " + String(product!.price)
    }
    
    var quantityStr: String? {
        return String(product!.quantity)
    }
    
    var quantityStr2: String? {
        return "x " + String(product!.quantity)
    }
    
    var price: Int {
        return product!.price
    }
    
    var quantity: Int {
        return product!.quantity
    }
    
    var stateStr: String? {
        switch _product!.state {
        case .waiting:
            return "未完成"
        case .finish:
            return "已完成"
        case .cancel:
            return "已取消"
        default:
            return ""
        }
    }
    
    var state: State {
        return _product!.state
    }
    
    var dateStr: String? {
        let logTime = _product!.logTime!
        return String(logTime[logTime.startIndex..<logTime.index(logTime.endIndex, offsetBy: -3)])
    }
    
    var product: CartProduct? {
        return _product
    }
    
    private var _product: CartProduct?
    private var _detail: String?
    
    //MARK:- Life cycle
    convenience init(_ product: CartProduct) {
        self.init()
        
        _product = product
        
        var detail = ""
        switch product.capacity {
//        case .short:
//            detail += "小" + "/"
        case .tall:
            detail += "中" + "/"
        case .grande:
            detail += "大" + "/"
        case .venti:
            detail += "超大" + "/"
        }
        switch product.temperature {
        case .less:
            detail += "冷" + "/"
        case .hot:
            detail += "热" + "/"
        default:
            ()
        }
        switch product.sugariness {
        case .free:
            detail += "正常"  
        case .less:
            detail += "少糖"
        case .semi:
            detail += "半糖"
//        case .total:
//            detail += "全糖"
        }
        
        _detail = detail
    }
}
