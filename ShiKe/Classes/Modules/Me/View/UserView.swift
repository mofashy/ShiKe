//
//  UserView.swift
//  ShiKe
//
//  Created by 沈永聪 on 2018/6/9.
//  Copyright © 2018年 沈永聪. All rights reserved.
//

import UIKit

class UserView: UIView {
    //MARK:- Members
    private lazy var imageView = UIImageView()
    private lazy var nameLabel = UILabel()
    private lazy var addressLabel = UILabel()
    
    var viewModel: UserViewModel? {
        didSet {
            nameLabel.text = viewModel?.nameStr
            addressLabel.text = viewModel?.addressStr
        }
    }
    
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
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 25
        imageView.layer.masksToBounds = true
        #if DEBUG
        imageView.backgroundColor = shike_color_darkGray
        #endif
        
        nameLabel.font = shike_mediumFont(16)
        nameLabel.textColor = shike_color_black
        
        addressLabel.font = shike_regularFont(12)
        addressLabel.textColor = shike_color_darkGray
        
        self.addSubview(imageView)
        self.addSubview(nameLabel)
        self.addSubview(addressLabel)
    }
    
    //MARK:- Layout
    func configLayout() {
        imageView.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(20)
            make.centerY.equalTo(self.snp.centerY)
            make.width.height.equalTo(50)
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(imageView.snp.right).offset(10)
            make.bottom.equalTo(imageView.snp.centerY)
            make.right.lessThanOrEqualTo(self.snp.right).offset(-20)
        }
        
        addressLabel.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel.snp.left)
            make.top.equalTo(imageView.snp.centerY)
            make.right.lessThanOrEqualTo(self.snp.right).offset(-20)
        }
    }
}
