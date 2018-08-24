//
//  ProfileHeader.swift
//  ShiKe
//
//  Created by 沈永聪 on 2018/6/9.
//  Copyright © 2018年 沈永聪. All rights reserved.
//

import UIKit

class ProfileHeader: UIView {
    //MARK:- Members
    var naviBlock: ((Int) -> Void)?
    var profileList: [[String: Any]]? {
        didSet {
            setupSubview()
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
    func setupSubview() {
        for subview in self.subviews {
            subview.removeFromSuperview()
        }
        
        let bounds = CGRect(x: 0, y: 0, width: shike_screen_width / 3, height: frame.size.height)
        if let profileList = profileList {
            let count = profileList.count
            for index in 0..<count {
                let dict = profileList[index] as Dictionary
                let button = UIButton()
                button.tag = index
                button.titleLabel?.font = shike_mediumFont(18)
                button.imageView?.tintColor = shike_color_lightPink
                button.frame = bounds.offsetBy(dx: CGFloat(index) * bounds.size.width, dy: 0)
                button.setImage(UIImage(named: dict["iconPath"] as! String), for: .normal)
                button.setTitle(dict["title"] as? String, for: .normal)
                button.setTitleColor(shike_color_black, for: .normal)
                button.titleLabel?.font = shike_mediumFont(16)
                button.titleEdgeInsets = UIEdgeInsets(top: button.imageView!.frame.size.height + 10, left: -button.imageView!.frame.size.width, bottom: 0, right: 0)
                button.imageEdgeInsets = UIEdgeInsets(top: -button.titleLabel!.bounds.size.height, left: 0, bottom: 0, right: -button.titleLabel!.bounds.size.width)
                button.addTarget(self, action: #selector(naviAction(_:)), for: .touchUpInside)
                self.addSubview(button)
            }
        }
    }
    
    //MARK:- Action
    @objc func naviAction(_ button: UIButton) {
        if let block = naviBlock {
            block(button.tag)
        }
    }
}
