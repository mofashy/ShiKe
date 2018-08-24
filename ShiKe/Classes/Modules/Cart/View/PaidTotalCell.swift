//
//  PaidTotalCell.swift
//  ShiKe
//
//  Created by 沈永聪 on 2018/6/13.
//  Copyright © 2018年 沈永聪. All rights reserved.
//

import UIKit

class PaidTotalCell: UITableViewCell {
    //MARK:- Members
    private lazy var separatorLine = UIView()
    private lazy var titleLabel1 = UILabel()
    private lazy var sumLabel = UILabel()
    private lazy var titleLabel2 = UILabel()
    private lazy var discountLabel = UILabel()
    private lazy var titleLabel3 = UILabel()
    private lazy var paidLabel = UILabel()
    
    var viewModel: PaidViewModel? {
        didSet {
            sumLabel.text = viewModel?.sum
            discountLabel.text = viewModel?.discount
            paidLabel.text = viewModel?.actuallyPay
        }
    }
    
    //MARK:- Life cycle
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupSubviews()
        configLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Setup
    func setupSubviews() {
        titleLabel1.font = shike_regularFont(12)
        titleLabel1.textColor = shike_color_darkGray
        titleLabel1.text = shike_localized("shike_lbl_txt_sum")
        
        sumLabel.font = shike_regularFont(12)
        sumLabel.textColor = shike_color_darkGray
        
        titleLabel2.font = shike_regularFont(12)
        titleLabel2.textColor = shike_color_darkGray
        titleLabel2.text = shike_localized("shike_lbl_txt_discount")
        
        discountLabel.font = shike_regularFont(12)
        discountLabel.textColor = shike_color_darkGray
        
        titleLabel3.font = shike_mediumFont(14)
        titleLabel3.textColor = shike_color_darkPink
        titleLabel3.text = shike_localized("shike_lbl_txt_actuallyPay")
        
        paidLabel.font = shike_mediumFont(14)
        paidLabel.textColor = shike_color_darkPink
        
        separatorLine.backgroundColor = shike_color_lightGray
        
        self.contentView.addSubview(separatorLine)
        self.contentView.addSubview(titleLabel1)
        self.contentView.addSubview(sumLabel)
        self.contentView.addSubview(titleLabel2)
        self.contentView.addSubview(discountLabel)
        self.contentView.addSubview(titleLabel3)
        self.contentView.addSubview(paidLabel)
    }
    
    //MARK:- Layout
    func configLayout() {
        separatorLine.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView.snp.left).offset(20)
            make.right.equalTo(self.contentView.snp.right).offset(-20)
            make.top.equalTo(self.contentView.snp.top)
            make.height.equalTo(1.0 / UIScreen.main.scale)
        }
        
        titleLabel1.snp.makeConstraints { (make) in
            make.left.equalTo(separatorLine.snp.left)
            make.centerY.equalTo(self.contentView.snp.centerY)
        }
        
        sumLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel1.snp.right)
            make.centerY.equalTo(self.contentView.snp.centerY)
        }
        
        titleLabel2.snp.makeConstraints { (make) in
            make.left.equalTo(sumLabel.snp.right).offset(20)
            make.centerY.equalTo(self.contentView.snp.centerY)
        }
        
        discountLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel2.snp.right)
            make.centerY.equalTo(self.contentView.snp.centerY)
        }
        
        paidLabel.snp.makeConstraints { (make) in
            make.right.equalTo(separatorLine.snp.right)
            make.centerY.equalTo(self.contentView.snp.centerY)
        }
        
        titleLabel3.snp.makeConstraints { (make) in
            make.right.equalTo(paidLabel.snp.left)
            make.centerY.equalTo(self.contentView.snp.centerY)
        }
    }
    
}
