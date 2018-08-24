//
//  LoginInputView.swift
//  ShiKe
//
//  Created by 沈永聪 on 2018/6/11.
//  Copyright © 2018年 沈永聪. All rights reserved.
//

import UIKit

enum TextFieldType {
    case username
    case password
    case verify
}

protocol LoginInputViewDelegate: NSObjectProtocol {
    func textChanged(text: String?, type: TextFieldType?)
}

class LoginInputView: UIView {
    //MARK:- Members
    private lazy var textBgView = UIView()
    private lazy var textField = UITextField()
    private lazy var getVerifyButton = UIButton()
    
    weak var delegate: LoginInputViewDelegate?
    
    var type: TextFieldType? {
        willSet {
            if let newValue = newValue {
                switch newValue {
                case .username:
                    textField.placeholder = shike_localized("shike_tfd_phr_username")
                case .password:
                    textField.placeholder = shike_localized("shike_tfd_phr_password")
                case .verify:
                    textField.placeholder = shike_localized("shike_tfd_phr_verify")
                }
                
                getVerifyButton.isHidden = newValue != .verify
                textField.isSecureTextEntry = newValue == .password
                configLayout()
            }
        }
    }
    
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
        textBgView.layer.cornerRadius = 20
        textBgView.layer.masksToBounds = true
        textBgView.layer.borderWidth = 1
        textBgView.layer.borderColor = shike_color_lightGray.cgColor
        
        textField.font = shike_mediumFont(14)
        textField.addTarget(self, action: #selector(textChanged(_:)), for: .editingChanged)
        
        getVerifyButton.titleLabel?.font = shike_regularFont(12)
        getVerifyButton.setTitle(shike_localized("shike_btn_title_getVerify"), for: .normal)
        getVerifyButton.setTitleColor(shike_color_darkPink, for: .normal)
        getVerifyButton.isHidden = true
        
        self.addSubview(textBgView)
        textBgView.addSubview(textField)
        self.addSubview(getVerifyButton)
    }
    
    //MARK:- Layout
    func configLayout() {
        textBgView.snp.removeConstraints()
        
        textBgView.snp.makeConstraints { (make) in
            make.edges.equalTo(self).inset(UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
        }
        
        getVerifyButton.snp.makeConstraints { (make) in
            make.right.equalTo(textBgView.snp.right).offset(-15)
            make.centerY.equalTo(textBgView.snp.centerY)
        }
        
        textField.snp.remakeConstraints { (make) in
            make.left.equalTo(textBgView.snp.left).offset(15)
            make.top.bottom.equalTo(self)
            if let type = type {
                switch type {
                case .verify:
                    make.right.equalTo(getVerifyButton.snp.left).offset(-15)
                default:
                    make.right.equalTo(textBgView.snp.right).offset(-15)
                }
            } else {
                make.right.equalTo(textBgView.snp.right).offset(-15)
            }
        }
    }
    
    //MARK:- Action
    @objc func textChanged(_ textField: UITextField) {
        self.delegate?.textChanged(text: textField.text, type: type)
    }

}
