//
//  Defines.swift
//  ShiKe
//
//  Created by 沈永聪 on 2018/6/7.
//  Copyright © 2018年 沈永聪. All rights reserved.
//

import UIKit

//MARK:- Color
let shike_color_darkPink = UIColor(hex: 0xF94664)
let shike_color_lightPink = UIColor(hex: 0xE18C96)
let shike_color_whitePink = UIColor(hex: 0xF8E9E9)
let shike_color_black = UIColor(hex: 0x0F0F0F)
let shike_color_darkGray = UIColor(hex: 0x999999)
let shike_color_lightGray = UIColor(hex: 0xDCDCDC)

//MARK:- Frame
let shike_screen_bounds = UIScreen.main.bounds
let shike_screen_size = shike_screen_bounds.size
let shike_screen_width = shike_screen_size.width
let shike_screen_height = shike_screen_size.height

//MARK:- Font
func shike_regularFont(_ size: CGFloat) -> UIFont? {
    return UIFont(name: "PingFangSC-Regular", size: size)
}

func shike_mediumFont(_ size: CGFloat) -> UIFont? {
    return UIFont(name: "PingFangSC-Medium", size: size)
}

//MARK:- NotificationName
let ShiKeCartProductsChangedNotification = "ShiKeCartProductsChangedNotification"
let ShiKeAddedProductsToCartNotification = "ShiKeAddedProductsToCartNotification"

//MARK:- Alias
func shike_localized(_ key: String) -> String {
    return NSLocalizedString(key, comment: "")
}

//MARK:- Extension
extension UIColor {
    convenience init(hex: Int) {
        self.init(red: (CGFloat)((hex & 0xFF0000) >> 16) / 255.0, green: (CGFloat)((hex & 0x00FF00) >> 8) / 255.0, blue: (CGFloat)(hex & 0x0000FF) / 255.0, alpha: 1.0)
    }
}
