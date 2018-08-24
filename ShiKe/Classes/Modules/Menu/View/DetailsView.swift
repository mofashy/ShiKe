//
//  DetailsView.swift
//  ShiKe
//
//  Created by 沈永聪 on 2018/6/9.
//  Copyright © 2018年 沈永聪. All rights reserved.
//

import UIKit

class DetailsView: UIView {
    //MARK:- Members
    private lazy var titleLabel = UILabel()
    private lazy var priceLabel = UILabel()
    private lazy var detailsLabel = UILabel()
    
    var viewModel: AddToCartViewModel? {
        didSet {
            titleLabel.text = viewModel?.titleStr
            priceLabel.text = viewModel?.priceStr
            #if DEBUG
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 5.0
            detailsLabel.attributedText = NSAttributedString(string: "玫瑰味的拿铁咖啡正如它的名字一般，永恒的爱。入口后回味悠长，醇香中还带着丝丝甜蜜，这不是爱情的味道么？", attributes: [.paragraphStyle: paragraphStyle])
            #endif
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
        titleLabel.textColor = shike_color_black
        titleLabel.font = shike_mediumFont(14)
        
        priceLabel.textColor = shike_color_darkPink
        priceLabel.font = shike_mediumFont(14)
        
        detailsLabel.textColor = shike_color_darkGray
        detailsLabel.font = shike_regularFont(12)
        detailsLabel.numberOfLines = 0
        detailsLabel.preferredMaxLayoutWidth = shike_screen_width - 40
        
        self.addSubview(titleLabel)
        self.addSubview(priceLabel)
        self.addSubview(detailsLabel)
    }
    
    //MARK:- Layout
    func configLayout() {
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(20)
            make.top.equalTo(self.snp.top).offset(25)
            make.right.lessThanOrEqualTo(priceLabel.snp.left).offset(-20)
        }
        
        priceLabel.snp.makeConstraints { (make) in
            make.right.equalTo(self.snp.right).offset(-20)
            make.centerY.equalTo(titleLabel.snp.centerY)
        }
        
        detailsLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel.snp.left)
            make.right.equalTo(priceLabel.snp.right)
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
            make.bottom.equalTo(self.snp.bottom).offset(-20)
        }
    }
    
    //MARK:- Calc
    func totalHeight() -> CGFloat {
        let titleHeight = titleLabel.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
        let detailsHeight = detailsLabel.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
        let totalHeight = 25.0 + titleHeight + 20.0 + detailsHeight + 20.0
        return totalHeight
    }
}
