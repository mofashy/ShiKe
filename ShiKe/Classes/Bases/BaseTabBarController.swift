//
//  BaseTabBarController.swift
//  ShiKe
//
//  Created by 沈永聪 on 2018/6/7.
//  Copyright © 2018年 沈永聪. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {
    override var prefersStatusBarHidden: Bool {
        return (self.selectedViewController?.prefersStatusBarHidden)!
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return (self.selectedViewController?.preferredStatusBarStyle)!
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return (self.selectedViewController?.supportedInterfaceOrientations)!
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return (self.selectedViewController?.preferredInterfaceOrientationForPresentation)!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.isTranslucent = false
    }
}
