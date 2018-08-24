//
//  AddToCartFooter.swift
//  ShiKe
//
//  Created by 沈永聪 on 2018/6/9.
//  Copyright © 2018年 沈永聪. All rights reserved.
//

import UIKit

class AddToCartFooter: UIView {
    //MARK:- Members
    private lazy var minusButton = UIButton()
    private lazy var quantityLabel = UILabel()
    private lazy var plusButton = UIButton()
    private lazy var settleButton = UIButton()
    
    var quantity = 1 {
        didSet {
            quantityLabel.text = String(quantity)
        }
    }
    var increaseBlock: (() -> ())?
    var decreaseBlock: (() -> ())?
    var settleBlock: (() -> ())?
    
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
        minusButton.setImage(UIImage(named: "subtract"), for: .normal)
        minusButton.addTarget(self, action: #selector(stepAction(_:)), for: .touchUpInside)
        
        quantityLabel.font = shike_regularFont(14)
        quantityLabel.textColor = shike_color_darkGray
        quantityLabel.textAlignment = .center
        quantityLabel.text = "1"
        
        plusButton.setImage(UIImage(named: "add"), for: .normal)
        plusButton.addTarget(self, action: #selector(stepAction(_:)), for: .touchUpInside)
        
        settleButton.setTitle(shike_localized("shike_btn_title_add"), for: .normal)
        settleButton.backgroundColor = shike_color_darkPink
        settleButton.layer.cornerRadius = 5
        settleButton.layer.masksToBounds = true
        settleButton.titleLabel?.font = shike_mediumFont(14)
        settleButton.addTarget(self, action: #selector(settleAction(_:)), for: .touchUpInside)
        
        self.addSubview(minusButton)
        self.addSubview(quantityLabel)
        self.addSubview(plusButton)
        self.addSubview(settleButton)
    }
    
    //MARK:- Layout
    func configLayout() {
        minusButton.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(20)
            make.centerY.equalTo(self.snp.centerY)
            make.height.width.equalTo(24)
        }
        
        quantityLabel.snp.makeConstraints { (make) in
            make.left.equalTo(minusButton.snp.right)
            make.right.equalTo(plusButton.snp.left)
            make.centerY.equalTo(self.snp.centerY)
            make.width.equalTo(25)
        }
        
        plusButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.height.width.equalTo(24)
        }
        
        settleButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.right.equalTo(self.snp.right).offset(-20)
            make.width.equalTo(114)
            make.height.equalTo(40)
        }
    }
    
    //MARK:- Action
    @objc func stepAction(_ button: UIButton) {
        if button == minusButton {
            if let block = decreaseBlock {
                block()
            }
        } else {
            if let block = increaseBlock {
                block()
            }
        }
    }
    
    @objc func settleAction(_ button: UIButton) {
        if let block = settleBlock {
            block()
        }
    }
}
