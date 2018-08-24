//
//  LoginViewModelInterface.swift
//  ShiKe
//
//  Created by 沈永聪 on 2018/6/12.
//  Copyright © 2018年 沈永聪. All rights reserved.
//

import Foundation
import UIKit

@objc protocol LoginViewModelDelegate {
    func reloadViews()
    func alertInfo()
    func reloadHome()
}

protocol LoginViewModelInterface {
    var delegate: LoginViewModelDelegate? { get set }
    
    var usernameBorderColor: UIColor? { get }
    var passwordBorderColor: UIColor? { get }
    var verifyBorderColor: UIColor? { get }
    
    var loginButtonEnable: Bool { get }
    var registerButtonEnable: Bool { get }
    
    func usernameDidChange(text: String?)
    func passwordDidChange(text: String?)
    func verifyDidChange(text: String?)
    
    func login()
    func register()
}
