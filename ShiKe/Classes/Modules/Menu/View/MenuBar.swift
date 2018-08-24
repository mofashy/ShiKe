//
//  MenuBar.swift
//  ShiKe
//
//  Created by 沈永聪 on 2018/6/8.
//  Copyright © 2018年 沈永聪. All rights reserved.
//

import UIKit

class MenuBar: UIView {
    //MARK:- Members
    let itemWidth: CGFloat = 56
    let lineWidth: CGFloat = 20
    let lineHeight: CGFloat = 4
    
    private lazy var buttons = Array<UIButton>()
    private lazy var indicatorLine = UIView()
    private var selectButton: UIButton!
    var switchBlock: ((Int) -> Void)?
    
    var menus: [String]? {
        didSet {
            setupItems()
            setupIndicatorLine()
        }
    }
    
    //MARK:- Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Setup
    func setupItems() {
        if let menus = menus {
            let count = menus.count
            let margin: CGFloat = 20
            let button = initButton(with: menus.first)
            
            var titleWidth = button.titleLabel!.sizeThatFits(.zero).width
            let leftInset = margin - (itemWidth - titleWidth) / 2.0
            titleWidth = initButton(with: menus.last).titleLabel!.sizeThatFits(.zero).width
            let rightInset = margin - (itemWidth - titleWidth) / 2.0
            let interitemSpacing = (shike_screen_width - (leftInset + rightInset + itemWidth * 2) - itemWidth * CGFloat(count - 2)) / CGFloat(count - 1)
            
            for index in 0..<menus.count {
                let title = menus[index]
                let button = initButton(with: title)
                
                self.addSubview(button)
                
                if index == 0 {
                    button.isSelected = true
                    selectButton = button
                }
                
                button.snp.makeConstraints { (make) in
                    switch index {
                    case 0:
                        make.left.equalTo(self.snp.left).offset(leftInset)
                    case count - 1:
                        make.right.equalTo(self.snp.right).offset(-rightInset)
                    default:
                        let prevButton = buttons.last!
                        make.left.equalTo(prevButton.snp.right).offset(interitemSpacing)
                    }
                    make.bottom.equalTo(self.snp.bottom).offset(-lineHeight)
                    make.width.equalTo(56)
                }
                
                buttons.append(button)
            }
        }
    }
    
    func setupIndicatorLine() {
        guard let button = buttons.first else {
            return
        }
        let titleWidth = button.titleLabel!.sizeThatFits(.zero).width
        let inset = 20 - (itemWidth - titleWidth) / 2.0
        
        indicatorLine.frame = CGRect(x: 0, y: 0, width: lineWidth, height: lineHeight)
        indicatorLine.center = CGPoint(x: inset + itemWidth / 2.0, y: self.frame.maxY - lineHeight * 2)
        indicatorLine.layer.cornerRadius = 2
        indicatorLine.layer.masksToBounds = true
        indicatorLine.backgroundColor = shike_color_darkPink
        self.addSubview(indicatorLine)
    }
    
    //MARK:- Initialzer
    func initButton(with title: String?) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(shike_color_darkGray, for: .normal)
        button.setTitleColor(shike_color_lightPink, for: .highlighted)
        button.setTitleColor(shike_color_darkPink, for: .selected)
        button.titleLabel?.font = shike_mediumFont(18)
        button.addTarget(self, action: #selector(switchAction(_:)), for: .touchUpInside)
        
        return button
    }
    
    //MARK:- Action
    @objc func switchAction(_ button: UIButton) {
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.indicatorLine.center = CGPoint(x: button.center.x, y: self.indicatorLine.center.y)
        }, completion: nil)
        
        selectButton.isSelected = false
        button.isSelected = true
        selectButton = button
        
        if let block = switchBlock {
            block(buttons.index(of: button)!)
        }
    }
}
