//
//  PaidHeader.swift
//  ShiKe
//
//  Created by 沈永聪 on 2018/6/13.
//  Copyright © 2018年 沈永聪. All rights reserved.
//

import UIKit

class PaidHeader: UIView {
    //MARK:- Members
    private lazy var titleLabel = UILabel()
    private lazy var dateLabel = UILabel()
    private lazy var separatorLine = UIView()
    
    //MARK:- life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
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
        titleLabel.text = shike_localized("shike_lbl_txt_orderDetail")
        
        dateLabel.font = shike_regularFont(12)
        dateLabel.textColor = shike_color_darkGray
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        dateLabel.text = formatter.string(from: Date())
        
        separatorLine.backgroundColor = shike_color_lightGray
        
        self.addSubview(titleLabel)
        self.addSubview(dateLabel)
        self.addSubview(separatorLine)
    }
    
    //MARK:- Layout
    func configLayout() {
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(20)
            make.centerY.equalTo(self.snp.centerY)
        }
        
        dateLabel.snp.makeConstraints { (make) in
            make.right.equalTo(self.snp.right).offset(-20)
            make.centerY.equalTo(self.snp.centerY)
        }
        
        separatorLine.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(20)
//            make.right.equalTo(self.snp.right).offset(-20)    // constraint conflict, replace by follows
            make.width.equalTo(frame.size.width - 40)
            make.bottom.equalTo(self.snp.bottom)
            make.height.equalTo(1.0 / UIScreen.main.scale)
        }
    }
}
