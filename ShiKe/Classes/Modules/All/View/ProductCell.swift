//
//  ProductCell.swift
//  ShiKe
//
//  Created by 沈永聪 on 2018/6/8.
//  Copyright © 2018年 沈永聪. All rights reserved.
//

import UIKit
import SnapKit

class ProductCell: UICollectionViewCell {
    //MARK:- Menbers
    var viewModel: ProductViewModel? {
        didSet {
            titleLabel.text = viewModel?.titleStr
            priceLabel.text = viewModel?.priceStr
        }
    }
    var addBlock: ((ProductViewModel) -> ())?
    
    private lazy var imageView = UIImageView()
    private lazy var titleLabel = UILabel()
    private lazy var priceLabel = UILabel()
    private lazy var addButton = UIButton()
    
    //MARK:- Life cycle
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
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 5.0
        imageView.layer.masksToBounds = true
        #if DEBUG
        imageView.backgroundColor = shike_color_darkPink
        #endif
        
        titleLabel.font = shike_mediumFont(14.0)
        priceLabel.font = shike_mediumFont(14.0)
        priceLabel.textColor = shike_color_darkPink
        
        addButton.setImage(UIImage(named: "add"), for: .normal)
        addButton.addTarget(self, action: #selector(addAction(_:)), for: .touchUpInside)
        
        self.contentView.addSubview(imageView)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(priceLabel)
        self.contentView.addSubview(addButton)
    }
    
    //MARK:- Layout
    func configLayout() {
        imageView.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(self.contentView)
            make.height.equalTo(imageView.snp.width)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(15)
            make.left.equalTo(imageView.snp.left).offset(8)
            make.right.lessThanOrEqualTo(addButton.snp.left).offset(-8)
        }
        
        priceLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel.snp.left)
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.right.lessThanOrEqualTo(addButton.snp.left).offset(-8)
        }
        
        addButton.snp.makeConstraints { (make) in
            make.right.equalTo(imageView.snp.right).offset(-8)
            make.centerY.equalTo(titleLabel.snp.bottom).offset(4)
            make.height.width.equalTo(24)
        }
    }
    
    //MARK:- Action
    @objc func addAction(_ button: UIButton) {
        if let block = addBlock {
            block(viewModel!)
        }
    }
    
}
