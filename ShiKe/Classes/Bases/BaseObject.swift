//
//  BaseObject.swift
//  ShiKe
//
//  Created by 沈永聪 on 2018/6/15.
//  Copyright © 2018年 沈永聪. All rights reserved.
//

import Foundation

@objc protocol BaseObjectInterface {
    func expectKeys() -> [String]?
}

class BaseObject: NSObject, BaseObjectInterface {
    convenience init(_ keyValues: [String: Any]) {
        self.init()
        
        self.setValuesForKeys(keyValues)
    }
    
    func keyValues() -> [String: Any] {
        var count: u_int = 0
        
        let ivarList = class_copyIvarList(type(of: self), &count)
        var keyValues = [String: Any]()
        for index in 0..<count {
            let ivar = ivarList![Int(index)]
            let name = String(utf8String: ivar_getName(ivar)!)
            
            if let key = name {
                if let expectKeys = self.expectKeys() {
                    if expectKeys.contains(key) { continue }
                }
                
                keyValues.updateValue(self.value(forKey: key)!, forKey: key)
            }
        }
        free(ivarList)
        
        return keyValues
    }
    
    func expectKeys() -> [String]? {
        return nil
    }
}
