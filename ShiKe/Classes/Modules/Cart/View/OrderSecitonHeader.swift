//
//  OrderSecitonHeader.swift
//  ShiKe
//
//  Created by 沈永聪 on 2018/6/13.
//  Copyright © 2018年 沈永聪. All rights reserved.
//

import UIKit

class OrderSecitonHeader: UICollectionReusableView {
    //MARK:- Members
    lazy var titleLabel = UILabel()
    
    //MARK:- Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = shike_color_lightGray
        
        setupSubviews()
        configLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Setup
    func setupSubviews() {
        titleLabel.font = shike_regularFont(14)
        titleLabel.textColor = shike_color_black
        
        self.addSubview(titleLabel)
    }
    
    //MARK:- Layout
    func configLayout() {
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(20)
            make.right.lessThanOrEqualTo(self.snp.right).offset(-20)
            make.centerY.equalTo(self.snp.centerY)
        }
    }
}
