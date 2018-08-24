//
//  LoginFooter.swift
//  ShiKe
//
//  Created by 沈永聪 on 2018/6/11.
//  Copyright © 2018年 沈永聪. All rights reserved.
//

import UIKit

class LoginFooter: UIView {
    //MARK:- Members
    private lazy var separatorLine = UIView()
    private lazy var prefixLabel = UILabel()
    private lazy var agreeLabel = UILabel()
    private lazy var groupView = UIView()
    
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
        separatorLine.backgroundColor = shike_color_lightGray
        
        prefixLabel.font = shike_regularFont(12)
        prefixLabel.textColor = shike_color_lightGray
        prefixLabel.text = shike_localized("shike_lbl_txt_agree_prefix")
        
        agreeLabel.font = shike_mediumFont(12)
        agreeLabel.textColor = shike_color_darkGray
        agreeLabel.text = shike_localized("shike_lbl_txt_agree")
        
        self.addSubview(separatorLine)
        self.addSubview(groupView)
        groupView.addSubview(prefixLabel)
        groupView.addSubview(agreeLabel)
    }
    
    //MARK:- Layout
    func configLayout() {
        separatorLine.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(self)
            make.height.equalTo(1.0 / UIScreen.main.scale)
        }
        
        groupView.snp.makeConstraints { (make) in
            make.center.equalTo(self.snp.center)
        }
        
        prefixLabel.snp.makeConstraints { (make) in
            make.left.top.bottom.equalTo(groupView)
            make.right.equalTo(agreeLabel.snp.left).offset(-20)
        }
        
        agreeLabel.snp.makeConstraints { (make) in
            make.right.top.bottom.equalTo(groupView)
        }
    }
}
