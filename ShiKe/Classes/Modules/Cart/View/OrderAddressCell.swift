//
//  OrderAddressCell.swift
//  ShiKe
//
//  Created by 沈永聪 on 2018/6/13.
//  Copyright © 2018年 沈永聪. All rights reserved.
//

import UIKit

class OrderAddressCell: UICollectionViewCell {
    //MARK:- Members
    private lazy var imageView = UIImageView()
    private lazy var addressLabel = UILabel()
    private lazy var usernameLabel = UILabel()
    private lazy var phoneLabel = UILabel()
    private lazy var indicatorView = UIImageView()
    
    //MARK:- Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        self.backgroundColor = UIColor.white
        
        setupSubviews()
        configLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Setup
    func setupSubviews() {
        imageView.image = UIImage(named: "location_2")
        imageView.contentMode = .scaleAspectFit
        
        addressLabel.font = shike_mediumFont(14)
        addressLabel.textColor = shike_color_black
        addressLabel.text = "广东省广州市天河区中山大道西"
        
        usernameLabel.font = shike_regularFont(12)
        usernameLabel.textColor = shike_color_darkGray
        usernameLabel.text = "L小姐"
        
        phoneLabel.font = shike_regularFont(12)
        phoneLabel.textColor = shike_color_darkGray
        phoneLabel.text = "135****9807"
        
        indicatorView.image = UIImage(named: "right_30")
        indicatorView.contentMode = .scaleAspectFit
        
        self.contentView.addSubview(imageView)
        self.contentView.addSubview(addressLabel)
        self.contentView.addSubview(usernameLabel)
        self.contentView.addSubview(phoneLabel)
        self.contentView.addSubview(indicatorView)
    }
    
    //MARK:- Layout
    func configLayout() {
        imageView.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView.snp.left).offset(20)
            make.centerY.equalTo(addressLabel.snp.centerY)
            make.height.width.equalTo(16)
        }
        
        addressLabel.snp.makeConstraints { (make) in
            make.left.equalTo(imageView.snp.right).offset(15)
            make.bottom.equalTo(self.contentView.snp.centerY)
            make.right.lessThanOrEqualTo(indicatorView.snp.left).offset(-15)
        }
        
        usernameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(addressLabel.snp.left)
            make.top.equalTo(self.contentView.snp.centerY).offset(5)
        }
        
        phoneLabel.snp.makeConstraints { (make) in
            make.left.equalTo(usernameLabel.snp.right).offset(20)
            make.centerY.equalTo(usernameLabel.snp.centerY)
            make.right.lessThanOrEqualTo(indicatorView.snp.left).offset(-15)
        }
        
        indicatorView.snp.makeConstraints { (make) in
            make.right.equalTo(self.contentView.snp.right).offset(-20)
            make.centerY.equalTo(self.contentView.snp.centerY)
            make.height.equalTo(14)
            make.width.equalTo(indicatorView.snp.height).multipliedBy(32.0 / 62.0)
        }
    }
    
    //MARK:- Calc
    func cellHeight() -> CGFloat {
        let addressHeight = addressLabel.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
        let usernameHeight = usernameLabel.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
        let totalHeight = 25.0 + addressHeight + 5 + usernameHeight + 25.0
        return totalHeight
    }
    
}
