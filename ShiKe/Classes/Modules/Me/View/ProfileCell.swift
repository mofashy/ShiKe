//
//  ProfileCell.swift
//  ShiKe
//
//  Created by 沈永聪 on 2018/6/9.
//  Copyright © 2018年 沈永聪. All rights reserved.
//

import UIKit

class ProfileCell: UITableViewCell {
    //MARK:- Members
    private lazy var iconView = UIImageView()
    private lazy var titleLabel = UILabel()
    
    var profile: [String: Any]? {
        willSet {
            if let newValue = newValue {
                iconView.image = UIImage(named: newValue["iconPath"] as! String)
                titleLabel.text = newValue["title"] as? String
            }
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
        iconView.contentMode = .scaleAspectFit
        
        titleLabel.font = shike_mediumFont(14)
        titleLabel.textColor = shike_color_black
        
        self.contentView.addSubview(iconView)
        self.contentView.addSubview(titleLabel)
    }
    
    //MARK:- Layout
    func configLayout() {
        iconView.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView.snp.left).offset(20)
            make.centerY.equalTo(self.contentView.snp.centerY)
            make.height.width.equalTo(30)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconView.snp.right).offset(10)
            make.centerY.equalTo(iconView.snp.centerY)
            make.right.lessThanOrEqualTo(self.contentView.snp.right).offset(-20)
        }
    }
}
