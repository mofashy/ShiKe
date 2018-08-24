//
//  BaseNavigationController.swift
//  ShiKe
//
//  Created by 沈永聪 on 2018/6/7.
//  Copyright © 2018年 沈永聪. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {
    override var prefersStatusBarHidden: Bool {
        return (self.topViewController?.prefersStatusBarHidden)!
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return (self.topViewController?.preferredStatusBarStyle)!
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return (self.topViewController?.supportedInterfaceOrientations)!
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return (self.topViewController?.preferredInterfaceOrientationForPresentation)!
    }
}
