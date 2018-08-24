//
//  OrdersCell.swift
//  ShiKe
//
//  Created by 沈永聪 on 2018/6/10.
//  Copyright © 2018年 沈永聪. All rights reserved.
//

import UIKit

class OrdersCell: UICollectionViewCell {
    //MARK:- Members
    private lazy var dateLabel = UILabel()
    private lazy var stateLabel = UILabel()
    private lazy var imageView = UIImageView()
    private lazy var titleLabel = UILabel()
    private lazy var detailsLabel = UILabel()
    private lazy var priceLabel = UILabel()
    private lazy var quantityLabel = UILabel()
    
    var viewModel: CartProductViewModel? {
        didSet {
            dateLabel.text = viewModel?.dateStr
            stateLabel.text = viewModel?.stateStr
            titleLabel.text = viewModel?.titleStr
            detailsLabel.text = viewModel?.detailStr
            priceLabel.text = viewModel?.priceStr
            quantityLabel.text = viewModel?.quantityStr
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
        dateLabel.font = shike_regularFont(10)
        dateLabel.textColor = shike_color_darkGray
        
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 3
        imageView.layer.masksToBounds = true
        #if DEBUG
        imageView.backgroundColor = shike_color_darkPink
        #endif
        
        titleLabel.font = shike_mediumFont(14)
        titleLabel.textColor = shike_color_black
        
        detailsLabel.font = shike_regularFont(10)
        detailsLabel.textColor = shike_color_darkGray
        
        priceLabel.font = shike_mediumFont(14)
        priceLabel.textColor = shike_color_darkPink
        
        stateLabel.font = shike_regularFont(12)
        stateLabel.textColor = shike_color_darkGray
        
        quantityLabel.font = shike_regularFont(12)
        quantityLabel.textColor = shike_color_darkGray
        
        self.contentView.addSubview(dateLabel)
        self.contentView.addSubview(imageView)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(detailsLabel)
        self.contentView.addSubview(priceLabel)
        self.contentView.addSubview(stateLabel)
        self.contentView.addSubview(quantityLabel)
    }
    
    //MARK:- Layout
    func configLayout() {
        dateLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView.snp.left).offset(10)
            make.top.equalTo(self.contentView.snp.top).offset(10)
        }
        
        imageView.snp.makeConstraints { (make) in
            make.left.equalTo(dateLabel.snp.left)
            make.top.equalTo(dateLabel.snp.bottom).offset(10)
            make.bottom.equalTo(self.contentView.snp.bottom).offset(-10)
            make.width.equalTo(imageView.snp.height)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(imageView.snp.right).offset(10)
            make.top.equalTo(imageView.snp.top)
            make.right.lessThanOrEqualTo(quantityLabel.snp.left).offset(-20)
        }
        
        detailsLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel.snp.left)
            make.top.equalTo(titleLabel.snp.bottom).offset(2)
            make.right.lessThanOrEqualTo(quantityLabel.snp.left).offset(-20)
        }
        
        priceLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel.snp.left)
            make.bottom.equalTo(imageView.snp.bottom).offset(2)
            make.right.lessThanOrEqualTo(quantityLabel.snp.right).offset(-20)
        }
        
        stateLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(dateLabel.snp.centerY)
            make.right.equalTo(self.contentView.snp.right).offset(-10)
        }
        
        quantityLabel.snp.makeConstraints { (make) in
            make.right.equalTo(stateLabel.snp.right)
            make.centerY.equalTo(detailsLabel.snp.centerY)
        }
    }
    
}
