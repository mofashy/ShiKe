//
//  LoginViewModel.swift
//  ShiKe
//
//  Created by 沈永聪 on 2018/6/12.
//  Copyright © 2018年 沈永聪. All rights reserved.
//

import UIKit

class LoginViewModel: NSObject, LoginViewModelInterface {
    weak var delegate: LoginViewModelDelegate?
    
    private var usernameValid = false
    private var passwordValid = false
    private var verifyValid = false
    
    private var username: String?
    private var password: String?
    private var verify: String?
    
    var usernameBorderColor: UIColor? {
        return usernameValid ? shike_color_lightGray : UIColor.red
    }
    
    var passwordBorderColor: UIColor? {
        return passwordValid ? shike_color_lightGray : UIColor.red
    }
    
    var verifyBorderColor: UIColor? {
        return verifyValid ? shike_color_lightGray : UIColor.red
    }
    
    var loginButtonEnable: Bool {
        return usernameValid && passwordValid
    }
    
    var registerButtonEnable: Bool {
        return usernameValid && passwordValid && verifyValid
    }
    
    func usernameDidChange(text: String?) {
        guard let textLength = text?.count else {
            delegate?.reloadViews()
            return
        }
        usernameValid = textLength >= 6
        username = text
        delegate?.reloadViews()
    }
    
    func passwordDidChange(text: String?) {
        guard let textLength = text?.count else {
            delegate?.reloadViews()
            return
        }
        passwordValid = textLength >= 6
        password = text
        delegate?.reloadViews()
    }
    
    func verifyDidChange(text: String?) {
        guard let textLength = text?.count else {
            delegate?.reloadViews()
            return
        }
        verifyValid = textLength >= 6
        verify = text
        delegate?.reloadViews()
    }
    
    func login() {
        //FIXME: 处理其他逻辑
        delegate?.reloadHome()
    }
    
    func register() {
        //FIXME: 处理其他逻辑
        delegate?.reloadHome()
    }
    
}
