//
//  CouponCell.swift
//  ShiKe
//
//  Created by 沈永聪 on 2018/6/10.
//  Copyright © 2018年 沈永聪. All rights reserved.
//

import UIKit

class CouponCell: UICollectionViewCell {
    //MARK:- Members
    private lazy var moneyLabel = UILabel()
    private lazy var pofixLabel = UILabel()
    private lazy var titleLabel = UILabel()
    private lazy var validLabel = UILabel()
    private lazy var leftBgView = UIView()
    private lazy var groupView = UIView()
    private lazy var useButton = UIButton()
    
    var useBlock: (() -> Void)?
    
    var viewModel: CouponViewModel? {
        didSet {
            moneyLabel.text = viewModel?.moneyStr
            titleLabel.text = viewModel?.titleStr
            validLabel.text = viewModel?.validStr
            
            let state = viewModel!.state!
            useButton.isEnabled = state == .unused
            useButton.layer.borderColor = state == .unused ?  shike_color_darkPink.cgColor : shike_color_darkGray.cgColor
        }
    }

    //MARK:- Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        self.backgroundColor = UIColor(hex: 0xFDF7F7)
        
        setupSubviews()
        configLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Setup
    func setupSubviews() {
        moneyLabel.font = shike_mediumFont(46)
        moneyLabel.textColor = UIColor.white
        
        pofixLabel.font = shike_mediumFont(10)
        pofixLabel.textColor = UIColor.white
        pofixLabel.text = shike_localized("shike_money_posfix")
        
        titleLabel.font = shike_mediumFont(14)
        titleLabel.textColor = shike_color_black
        
        validLabel.font = shike_regularFont(10)
        validLabel.textColor = shike_color_darkGray
        
        leftBgView.backgroundColor = UIColor(hex: 0xFF8094)
        
        useButton.setTitle(shike_localized("shike_btn_title_use"), for: .normal)
        useButton.setTitleColor(shike_color_darkPink, for: .normal)
        useButton.setTitleColor(shike_color_darkGray, for: .disabled)
        useButton.titleLabel?.font = shike_regularFont(12)
        useButton.layer.cornerRadius = 15
        useButton.layer.borderWidth = 1
        useButton.layer.borderColor = shike_color_darkPink.cgColor
        useButton.layer.masksToBounds = true
        useButton.addTarget(self, action: #selector(useAction(_:)), for: .touchUpInside)
        
        self.contentView.addSubview(leftBgView)
        leftBgView.addSubview(groupView)
        groupView.addSubview(moneyLabel)
        groupView.addSubview(pofixLabel)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(validLabel)
        self.contentView.addSubview(useButton)
    }
    
    //MARK:- Layout
    func configLayout() {
        leftBgView.snp.makeConstraints { (make) in
            make.left.top.bottom.equalTo(self.contentView)
            make.width.equalTo(80)
        }
        
        groupView.snp.makeConstraints { (make) in
            make.centerX.centerY.equalTo(leftBgView)
            make.left.greaterThanOrEqualTo(leftBgView.snp.left)
            make.right.lessThanOrEqualTo(leftBgView.snp.right)
        }
        
        moneyLabel.snp.makeConstraints { (make) in
            make.left.top.bottom.equalTo(groupView)
            make.right.equalTo(pofixLabel.snp.left)
        }
        
        pofixLabel.snp.makeConstraints { (make) in
            make.right.equalTo(groupView.snp.right)
            make.bottom.equalTo(moneyLabel.snp.bottom).offset(-12)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(leftBgView.snp.right).offset(15)
            make.bottom.equalTo(leftBgView.snp.centerY)
            make.right.lessThanOrEqualTo(useButton.snp.left).offset(-15)
        }
        
        validLabel.snp.makeConstraints { (make) in
            make.top.equalTo(leftBgView.snp.centerY).offset(2)
            make.left.equalTo(titleLabel.snp.left)
            make.right.lessThanOrEqualTo(useButton.snp.left).offset(-15)
        }
        
        useButton.snp.makeConstraints { (make) in
            make.right.equalTo(self.contentView.snp.right).offset(-15)
            make.centerY.equalTo(leftBgView.snp.centerY)
            make.size.equalTo(CGSize(width: 64, height: 30))
        }
    }
    
    //MARK:- Action
    @objc func useAction(_ button: UIButton) {
        if let block = useBlock {
            block()
        }
    }
    
}
