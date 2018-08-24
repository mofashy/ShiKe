//
//  OrderFooter.swift
//  ShiKe
//
//  Created by 沈永聪 on 2018/6/13.
//  Copyright © 2018年 沈永聪. All rights reserved.
//

import UIKit

class OrderFooter: UIView {
    //MARK:- Members
    private lazy var separatorLine = UIView()
    private lazy var titleLabel1 = UILabel()
    private lazy var sumLabel = UILabel()
    private lazy var titleLabel2 = UILabel()
    private lazy var discountLabel = UILabel()
    private lazy var payButton = UIButton()
    
    var viewModel: PaidViewModel? {
        didSet {
            sumLabel.text = viewModel?.sum
            discountLabel.text = viewModel?.discount
        }
    }
    
    var payBlock: (() -> ())?
    
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
        
        titleLabel1.font = shike_mediumFont(14)
        titleLabel1.textColor = shike_color_black
        titleLabel1.setContentHuggingPriority(.required, for: .horizontal)
        titleLabel1.text = shike_localized("shike_lbl_txt_total")
        
        sumLabel.font = shike_mediumFont(14)
        sumLabel.textColor = shike_color_darkPink
        
        titleLabel2.font = shike_regularFont(12)
        titleLabel2.textColor = shike_color_darkGray
        titleLabel2.text = shike_localized("shike_lbl_txt_discount")
        
        discountLabel.font = shike_regularFont(12)
        discountLabel.textColor = shike_color_darkGray
        
        payButton.setTitle(shike_localized("shike_btn_title_pay"), for: .normal)
        payButton.backgroundColor = shike_color_darkPink
        payButton.layer.cornerRadius = 5
        payButton.layer.masksToBounds = true
        payButton.titleLabel?.font = shike_mediumFont(14)
        payButton.addTarget(self, action: #selector(payAction(_:)), for: .touchUpInside)
        
        self.addSubview(separatorLine)
        self.addSubview(titleLabel1)
        self.addSubview(sumLabel)
        self.addSubview(titleLabel2)
        self.addSubview(discountLabel)
        self.addSubview(payButton)
    }
    
    //MARK:- Layout
    func configLayout() {
        separatorLine.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self)
            make.height.equalTo(1.0 / UIScreen.main.scale)
        }
        
        titleLabel1.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(20)
            make.centerY.equalTo(self.snp.centerY)
        }
        
        sumLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel1.snp.right)
            make.centerY.equalTo(self.snp.centerY)
        }
        
        titleLabel2.snp.makeConstraints { (make) in
            make.left.equalTo(sumLabel.snp.right).offset(20)
            make.centerY.equalTo(self.snp.centerY)
        }
        
        discountLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel2.snp.right)
            make.centerY.equalTo(self.snp.centerY)
            make.right.lessThanOrEqualTo(payButton.snp.left).offset(-10)
        }
        
        payButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.right.equalTo(self.snp.right).offset(-20)
            make.width.equalTo(114)
            make.height.equalTo(40)
        }
    }
    
    //MARK:- Action
    
    @objc func payAction(_ button: UIButton) {
        if let block = payBlock {
            block()
        }
    }

}
