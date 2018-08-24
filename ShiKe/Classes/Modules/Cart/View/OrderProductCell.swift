//
//  OrderProductCell.swift
//  ShiKe
//
//  Created by 沈永聪 on 2018/6/13.
//  Copyright © 2018年 沈永聪. All rights reserved.
//

import UIKit

enum MaskEdge {
    case top
    case bottom
}

class OrderProductCell: UICollectionViewCell {
    //MARK:- Members
    private lazy var imageView = UIImageView()
    private lazy var titleLabel = UILabel()
    private lazy var detailsLabel = UILabel()
    private lazy var priceLabel = UILabel()
    private lazy var quantityLabel = UILabel()
    
    var viewModel: CartProductViewModel? {
        didSet {
            titleLabel.text = viewModel?.titleStr
            detailsLabel.text = viewModel?.detailStr
            priceLabel.text = viewModel?.priceStr
            quantityLabel.text = viewModel?.quantityStr2
        }
    }
    
    //MARK:- Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
//        self.layer.cornerRadius = 5
//        self.layer.masksToBounds = true
        self.backgroundColor = UIColor.white
        
        setupSubviews()
        configLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Setup
    func setupSubviews() {
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
        
        quantityLabel.font = shike_regularFont(12)
        quantityLabel.textColor = shike_color_darkGray
        
        self.contentView.addSubview(imageView)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(detailsLabel)
        self.contentView.addSubview(priceLabel)
        self.contentView.addSubview(quantityLabel)
    }
    
    //MARK:- Layout
    func configLayout() {
        imageView.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView.snp.left).offset(20)
            make.top.equalTo(self.contentView.snp.top).offset(20)
            make.bottom.equalTo(self.contentView.snp.bottom).offset(-20)
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
        
        quantityLabel.snp.makeConstraints { (make) in
            make.right.equalTo(self.contentView.snp.right).offset(-20)
            make.centerY.equalTo(detailsLabel.snp.centerY)
        }
    }
    
    func maskTop() {
        mask(edge: .top)
    }
    
    func maskBottom() {
        mask(edge: .bottom)
    }
    
    private func mask(edge: MaskEdge) {
        let maskLayer = CAShapeLayer()
        if edge == .top {
            maskLayer.path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: UIRectCorner(rawValue: UIRectCorner.topLeft.rawValue | UIRectCorner.topRight.rawValue), cornerRadii: CGSize(width: 5, height: 5)).cgPath
        } else {
            maskLayer.path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: UIRectCorner(rawValue: UIRectCorner.bottomLeft.rawValue | UIRectCorner.bottomRight.rawValue), cornerRadii: CGSize(width: 5, height: 5)).cgPath
        }
        self.layer.mask = maskLayer
        self.layer.masksToBounds = true
    }
    
}
