//
//  BaseViewController.swift
//  ShiKe
//
//  Created by 沈永聪 on 2018/6/7.
//  Copyright © 2018年 沈永聪. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    //MARK:- Appearance
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .portrait
    }
    
    //MARK:- Life cycle
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.white
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "left_90"), style: .plain, target: self, action: #selector(backAction(_:)))
        self.navigationController?.navigationBar.tintColor = shike_color_black
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.navigationBar.barTintColor = UIColor.white
    }
    
    deinit {
        print("\(type(of: self)) deinit")
    }
    
    //MARK:- Setup
    func setupNavItems(title: String?) {
        let label = UILabel()
        label.text = title
        label.textColor = shike_color_black
        label.font = shike_mediumFont(26)
        label.sizeToFit()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: label)
    }
    
    //MARK:- Action
    @objc func backAction(_ barButtonItem: UIBarButtonItem) {
        if let naviVC = self.navigationController {
            naviVC.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
}
