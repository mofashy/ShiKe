//
//  OptionalView.swift
//  ShiKe
//
//  Created by 沈永聪 on 2018/6/9.
//  Copyright © 2018年 沈永聪. All rights reserved.
//

import UIKit

class OptionalView: UIView {
    //MARK:- Members
    private lazy var titleLabel = UILabel()
    private lazy var buttons = Array<UIButton>()
    private var selectedButton: UIButton!
    
    var dict: [String: Any]? {
        didSet {
            titleLabel.text = dict!["title"] as? String
            setupButtons()
        }
    }
    var choiceBlock: ((Int) -> ())?
    
    //MARK:- Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        
        setupTitleLabel()
        configLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Setup
    func setupTitleLabel() {
        titleLabel.textColor = shike_color_black
        titleLabel.font = shike_mediumFont(13)
        titleLabel.setContentHuggingPriority(.required, for: .horizontal)
        
        self.addSubview(titleLabel)
    }
    
    func setupButtons() {
        buttons.removeAll()
        
        func initButton(with title: String) -> UIButton {
            let button = UIButton()
            button.setTitle(title, for: .normal)
            button.setTitleColor(shike_color_lightGray, for: .normal)
            button.setTitleColor(shike_color_darkPink, for: .selected)
            button.titleLabel?.font = shike_regularFont(13)
            button.layer.cornerRadius = 15
            button.layer.borderWidth = 1
            button.layer.borderColor = shike_color_lightGray.cgColor
            button.layer.masksToBounds = true
            button.addTarget(self, action: #selector(switchAction(_:)), for: .touchUpInside)
            
            return button
        }
        
        if let optionals = dict!["optional"] as! [String]? {
            for index in 0..<optionals.count {
                let button = initButton(with: optionals[index])
                button.tag = index
                self.addSubview(button)
                buttons.append(button)
                
                if index == 0 {
                    selectedButton = button
                    selectedButton.isSelected = true
                    selectedButton.layer.borderColor = shike_color_darkPink.cgColor
                }
            }
            
            configLayout()
        }
    }
    
    //MARK:- Layout
    func configLayout() {
        titleLabel.snp.removeConstraints()
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(20)
            make.centerY.equalTo(self.snp.centerY)
        }
        
        var prevButton: UIButton?
        for button in buttons {
            button.snp.makeConstraints { (make) in
                make.centerY.equalTo(titleLabel.snp.centerY)
                make.height.equalTo(30)
                if let prevButton = prevButton {
                    make.left.equalTo(prevButton.snp.right).offset(20)
                    make.width.equalTo(prevButton.snp.width)
                } else {
                    make.left.equalTo(titleLabel.snp.right).offset(20)
                }
                
                if button == buttons.last {
                    make.right.equalTo(self.snp.right).offset(-20)
                }
            }
            
            prevButton = button
        }
    }
    
    //MARK:- Action
    @objc func switchAction(_ button: UIButton) {
        selectedButton.isSelected = false
        selectedButton.layer.borderColor = shike_color_lightGray.cgColor
        
        button.isSelected = true
        button.layer.borderColor = shike_color_darkPink.cgColor
        selectedButton = button
        
        if let block = choiceBlock {
            block(button.tag)
        }
    }
}
