//
//  LoginButtonView.swift
//  ShiKe
//
//  Created by 沈永聪 on 2018/6/11.
//  Copyright © 2018年 沈永聪. All rights reserved.
//

import UIKit

enum ButtonType {
    case login
    case register
}

class LoginButtonView: UIView {
    //MARK:- Members
    private lazy var button = UIButton()
    var type: ButtonType = .login {
        willSet {
            if newValue == .login {
                button.setTitle(shike_localized("shike_btn_title_login"), for: .normal)
            } else {
                button.setTitle(shike_localized("shike_btn_title_register"), for: .normal)
            }
        }
    }
    
    var block: (() -> Void)?
    
    //MARK:- Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        
        setupSubviews()
        configLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Setup
    func setupSubviews() {
        button.isEnabled = false
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.backgroundColor = shike_color_lightGray
        button.titleLabel?.font = shike_mediumFont(14)
        button.setTitle(shike_localized("shike_btn_title_login"), for: .normal)
        button.addTarget(self, action: #selector(onClickButton(_:)), for: .touchUpInside)
        
        self.addSubview(button)
    }
    
    //MARK:- Layout
    func configLayout() {
        button.snp.makeConstraints { (make) in
            make.edges.equalTo(self).inset(UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
        }
    }
    
    //MARK:- Action
    @objc func onClickButton(_ button: UIButton) {
        if let block = block {
            block()
        }
    }
    
    public func enableButton(isEnabled: Bool) {
        button.isEnabled = isEnabled
        button.backgroundColor = isEnabled ? shike_color_darkPink : shike_color_lightGray
    }

}
