//
//  PaidProductCell.swift
//  ShiKe
//
//  Created by 沈永聪 on 2018/6/13.
//  Copyright © 2018年 沈永聪. All rights reserved.
//

import UIKit

class PaidProductCell: UITableViewCell {
    //MARK:- Members
    private lazy var titleLabel = UILabel()
    private lazy var detailsLabel = UILabel()
    private lazy var quantityLabel = UILabel()
    private lazy var priceLabel = UILabel()
    
    var viewModel: CartProductViewModel? {
        didSet {
            titleLabel.text = viewModel?.titleStr
            detailsLabel.text = viewModel?.detailStr
            quantityLabel.text = viewModel?.quantityStr2
            priceLabel.text = viewModel?.priceStr
        }
    }
    
    //MARK:- Life cycle
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        
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
        
        detailsLabel.font = shike_regularFont(10)
        detailsLabel.textColor = shike_color_darkGray
        
        quantityLabel.font = shike_regularFont(12)
        quantityLabel.textColor = shike_color_darkGray
        quantityLabel.textAlignment = .center
        
        priceLabel.font = shike_mediumFont(14)
        priceLabel.textColor = shike_color_black
        priceLabel.setContentHuggingPriority(.required, for: .horizontal)
        
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(detailsLabel)
        self.contentView.addSubview(quantityLabel)
        self.contentView.addSubview(priceLabel)
    }
    
    //MARK:- Layout
    func configLayout() {
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView.snp.left).offset(20)
            make.bottom.equalTo(self.contentView.snp.centerY)
            make.right.lessThanOrEqualTo(quantityLabel.snp.left).offset(-10)
        }
        
        detailsLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel.snp.left)
            make.top.equalTo(self.contentView.snp.centerY).offset(2)
            make.right.lessThanOrEqualTo(quantityLabel.snp.left).offset(-10)
        }
        
        priceLabel.snp.makeConstraints { (make) in
            make.right.equalTo(self.contentView.snp.right).offset(-20)
            make.centerY.equalTo(self.contentView.snp.centerY)
        }
        
        quantityLabel.snp.makeConstraints { (make) in
            make.right.equalTo(priceLabel.snp.left).offset(-20)
            make.centerY.equalTo(self.contentView.snp.centerY)
        }
    }
    
}
