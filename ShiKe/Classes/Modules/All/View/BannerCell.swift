//
//  BannerCell.swift
//  ShiKe
//
//  Created by 沈永聪 on 2018/6/8.
//  Copyright © 2018年 沈永聪. All rights reserved.
//

import UIKit

class BannerCell: UICollectionViewCell {
    //MARK:- Members
    private lazy var imageView: UIImageView = UIImageView()
    
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
        
        self.contentView.addSubview(imageView)
    }
    
    //MARK:- Layout
    func configLayout() {
        imageView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.contentView)
        }
    }
}
