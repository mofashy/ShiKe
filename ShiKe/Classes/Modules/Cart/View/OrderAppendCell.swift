//
//  OrderAppendCell.swift
//  ShiKe
//
//  Created by 沈永聪 on 2018/6/13.
//  Copyright © 2018年 沈永聪. All rights reserved.
//

import UIKit

enum AccessoryType {
    case none
    case indicator
}

class OrderAppendCell: UICollectionViewCell {
    //MARK:- Members
    lazy var titleLabel = UILabel()
    lazy var detailsLabel = UILabel()
    private lazy var indicatorView = UIImageView()
    
    var accessoryType: AccessoryType = .none {
        didSet {
            indicatorView.isHidden = accessoryType == .none
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
        titleLabel.font = shike_mediumFont(14)
        titleLabel.textColor = shike_color_black
        titleLabel.setContentHuggingPriority(.required, for: .horizontal)
        
        detailsLabel.font = shike_mediumFont(14)
        detailsLabel.textColor = shike_color_darkGray
        
        indicatorView.image = UIImage(named: "right_30")
        indicatorView.contentMode = .scaleAspectFit
        indicatorView.isHidden = true
        
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(detailsLabel)
        self.contentView.addSubview(indicatorView)
    }
    
    //MARK:- Layout
    func configLayout() {
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView.snp.left).offset(20)
            make.centerY.equalTo(self.contentView.snp.centerY)
        }
        
        detailsLabel.snp.makeConstraints { (make) in
            make.left.greaterThanOrEqualTo(titleLabel.snp.right).offset(20)
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.right.equalTo(indicatorView.snp.left).offset(-10)
        }
        
        indicatorView.snp.makeConstraints { (make) in
            make.right.equalTo(self.contentView.snp.right).offset(-20)
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.height.equalTo(14)
            make.width.equalTo(indicatorView.snp.height).multipliedBy(32.0 / 62.0)
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
