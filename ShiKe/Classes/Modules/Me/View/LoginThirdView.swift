//
//  LoginThirdView.swift
//  ShiKe
//
//  Created by 沈永聪 on 2018/6/11.
//  Copyright © 2018年 沈永聪. All rights reserved.
//

import UIKit

class LoginThirdView: UIView {
    //MARK:- Members
    private lazy var qqButton = UIButton()
    private lazy var wechatButton = UIButton()
    private lazy var weiboButton = UIButton()
    
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
        qqButton.setImage(UIImage(named: "sns_icon_24"), for: .normal)
        
        wechatButton.setImage(UIImage(named: "sns_icon_22"), for: .normal)
        
        weiboButton.setImage(UIImage(named: "sns_icon_1"), for: .normal)
        
        self.addSubview(qqButton)
        self.addSubview(wechatButton)
        self.addSubview(weiboButton)
    }
    
    //MARK:- Layout
    func configLayout() {
        qqButton.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(40)
            make.centerY.equalTo(self.snp.centerY)
            make.height.width.equalTo(50)
        }
        
        wechatButton.snp.makeConstraints { (make) in
            make.center.equalTo(self.snp.center)
            make.height.width.equalTo(50)
        }
        
        weiboButton.snp.makeConstraints { (make) in
            make.right.equalTo(self.snp.right).offset(-40)
            make.centerY.equalTo(self.snp.centerY)
            make.height.width.equalTo(50)
        }
    }
    
}
