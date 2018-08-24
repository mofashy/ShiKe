//
//  CategoryHeader.swift
//  ShiKe
//
//  Created by 沈永聪 on 2018/6/8.
//  Copyright © 2018年 沈永聪. All rights reserved.
//

import UIKit

class CategoryHeader: UITableViewHeaderFooterView {
    //MARK:- Members
    var viewModel: CategoryViewModel? {
        didSet {
            titleLabel.text = viewModel?.titleStr
            detailLabel.text = viewModel?.detailStr
        }
    }
    
    private lazy var titleLabel: UILabel = UILabel()
    private lazy var detailLabel: UILabel = UILabel()
    private lazy var navButton: UIButton = UIButton()
    
    //MARK:- Life cycle
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = UIColor.white
        
        setupSubviews()
        configLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Setup
    func setupSubviews() {
        titleLabel.font = shike_mediumFont(16)
        titleLabel.textColor = shike_color_black
        
        detailLabel.font = shike_mediumFont(13)
        detailLabel.textColor = shike_color_lightGray
        
        navButton.setTitle(shike_localized("shike_btn_title_more"), for: .normal)
        navButton.setTitleColor(shike_color_lightGray, for: .normal)
        navButton.titleLabel?.font = shike_mediumFont(13)
        navButton.addTarget(self, action: #selector(navAction), for: .touchUpInside)
        
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(detailLabel)
        self.contentView.addSubview(navButton)
    }
    
    //MARK:- Layout
    func configLayout() {
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(20)
            make.top.equalTo(self.snp.top).offset(10)
        }
        
        detailLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel.snp.left)
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
        }
        
        navButton.snp.makeConstraints { (make) in
            make.right.equalTo(self.snp.right).offset(-20)
            make.centerY.equalTo(detailLabel.snp.centerY)
        }
    }
    
    //MARK:- Action
    @objc func navAction() {
        //TODO:
    }
}
