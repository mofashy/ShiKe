//
//  CartTotalView.swift
//  ShiKe
//
//  Created by 沈永聪 on 2018/6/9.
//  Copyright © 2018年 沈永聪. All rights reserved.
//

import UIKit

class CartTotalView: UIView {
    //MARK:- Members
    private lazy var separatorLine = UIView()
    private lazy var checkbox = UIButton()
    private lazy var titleLabel = UILabel()
    private lazy var priceLabel = UILabel()
    private lazy var settleButton = UIButton()
    
    var viewModel: CartViewModel? {
        didSet {
            checkbox.isSelected = viewModel!.isCheck
            priceLabel.text = viewModel?.totalStr
        }
    }
    
    var settleBlock: (() -> ())?
    
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
        
        checkbox.adjustsImageWhenHighlighted = false
        checkbox.setImage(UIImage(named: "uncheck"), for: .normal)
        checkbox.setImage(UIImage(named: "check"), for: .selected)
        checkbox.addTarget(self, action: #selector(checkAction(_:)), for: .touchUpInside)
        
        titleLabel.font = shike_mediumFont(16)
        titleLabel.textColor = shike_color_black
        titleLabel.text = shike_localized("shike_lbl_txt_total")
        
        priceLabel.font = shike_mediumFont(16)
        priceLabel.textColor = shike_color_darkPink
        
        settleButton.setTitle(shike_localized("shike_btn_title_settle"), for: .normal)
        settleButton.backgroundColor = shike_color_darkPink
        settleButton.layer.cornerRadius = 5
        settleButton.layer.masksToBounds = true
        settleButton.titleLabel?.font = shike_mediumFont(14)
        settleButton.addTarget(self, action: #selector(settleAction(_:)), for: .touchUpInside)
        
        self.addSubview(separatorLine)
        self.addSubview(checkbox)
        self.addSubview(titleLabel)
        self.addSubview(priceLabel)
        self.addSubview(settleButton)
    }
    
    //MARK:- Layout
    func configLayout() {
        separatorLine.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self)
            make.height.equalTo(1.0 / UIScreen.main.scale)
        }
        
        checkbox.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(20)
            make.centerY.equalTo(self.snp.centerY)
            make.height.width.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.right.equalTo(priceLabel.snp.left).offset(-10)
            make.centerY.equalTo(self.snp.centerY)
        }
        
        priceLabel.snp.makeConstraints { (make) in
            make.right.equalTo(settleButton.snp.left).offset(-10)
            make.centerY.equalTo(self.snp.centerY)
            make.width.greaterThanOrEqualTo(40)
        }
        
        settleButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.right.equalTo(self.snp.right).offset(-20)
            make.width.equalTo(114)
            make.height.equalTo(40)
        }
    }
    
    //MARK:- Action
    @objc func checkAction(_ button: UIButton) {
//        button.isSelected = !button.isSelected
        
        viewModel?.checkboxDidChecked(!button.isSelected)
//        button.isSelected = viewModel!.isCheck
    }
    
    @objc func settleAction(_ button: UIButton) {
        if let block = settleBlock {
            block()
        }
    }
}
