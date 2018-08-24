//
//  LoginMenuBar.swift
//  ShiKe
//
//  Created by 沈永聪 on 2018/6/11.
//  Copyright © 2018年 沈永聪. All rights reserved.
//

import UIKit

class LoginMenuBar: UIView {
    //MARK:- Members
    let itemWidth: CGFloat = shike_screen_width / 2
    let lineWidth: CGFloat = 20
    let lineHeight: CGFloat = 4
    
    private lazy var menus = ["登录", "注册"]
    private lazy var loginButton = UIButton()
    private lazy var registerButton = UIButton()
    private lazy var indicatorLine = UIView()
    var switchBlock: ((ButtonType) -> Void)?
    
    //MARK:- Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubviews()
        configLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Setup
    func setupSubviews() {
        loginButton.tag = 0
        loginButton.isSelected = true
        loginButton.setTitle(menus.first, for: .normal)
        loginButton.titleLabel?.font = shike_mediumFont(18)
        loginButton.setTitleColor(shike_color_black, for: .normal)
        loginButton.setTitleColor(shike_color_lightPink, for: .highlighted)
        loginButton.setTitleColor(shike_color_darkPink, for: .selected)
        loginButton.addTarget(self, action: #selector(switchAction(_:)), for: .touchUpInside)
        
        registerButton.tag = 1
        registerButton.setTitle(menus.last, for: .normal)
        registerButton.titleLabel?.font = shike_mediumFont(18)
        registerButton.setTitleColor(shike_color_black, for: .normal)
        registerButton.setTitleColor(shike_color_lightPink, for: .highlighted)
        registerButton.setTitleColor(shike_color_darkPink, for: .selected)
        registerButton.addTarget(self, action: #selector(switchAction(_:)), for: .touchUpInside)
        
//        indicatorLine.frame = CGRect(x: 0, y: 0, width: lineWidth, height: lineHeight)
//        indicatorLine.center = CGPoint(x: itemWidth / 2, y: self.frame.midX + lineHeight * 2)
        indicatorLine.layer.cornerRadius = 2
        indicatorLine.layer.masksToBounds = true
        indicatorLine.backgroundColor = shike_color_darkPink
        
        self.addSubview(loginButton)
        self.addSubview(registerButton)
        self.addSubview(indicatorLine)
    }
    
    //MARK:- Layout
    func configLayout() {
        loginButton.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left)
            make.right.equalTo(registerButton.snp.left)
            make.width.equalTo(registerButton.snp.width)
            make.centerY.equalTo(self.snp.centerY).offset(-10)
        }
        
        registerButton.snp.makeConstraints { (make) in
            make.right.equalTo(self.snp.right)
            make.centerY.equalTo(loginButton.snp.centerY)
        }
        
        indicatorLine.snp.makeConstraints { (make) in
            make.top.equalTo(loginButton.snp.bottom)
            make.centerX.equalTo(loginButton.snp.centerX)
            make.size.equalTo(CGSize(width: lineWidth, height: lineHeight))
        }
    }
    
    //MARK:- Action
    @objc func switchAction(_ button: UIButton) {
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.indicatorLine.center = CGPoint(x: button.center.x, y: self.indicatorLine.center.y)
        }, completion: nil)
        
        loginButton.isSelected = button == loginButton
        registerButton.isSelected = button == registerButton
        
        let types: [ButtonType] = [.login, .register]
        if let block = switchBlock {
            block(types[button.tag])
        }
    }

}
