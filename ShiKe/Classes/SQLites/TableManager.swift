//
//  TableManager.swift
//  ShiKe
//
//  Created by 沈永聪 on 2018/6/15.
//  Copyright © 2018年 沈永聪. All rights reserved.
//

import UIKit

let TABLE_CART = "TB_CART"

class TableManager: NSObject {
    static let shared = TableManager()
    private override init() { }
    
    @discardableResult public func createTables() -> Bool {
        return SQLiteManager.shared.createTable(TABLE_CART, keyValues: [
            "coverUrl": SQLITE_TYPE_TEXT,
            "name": SQLITE_TYPE_TEXT,
            "price": SQLITE_TYPE_INTEGER,
            "quantity": SQLITE_TYPE_INTEGER,
            "capacity": SQLITE_TYPE_TEXT,
            "sugariness": SQLITE_TYPE_TEXT,
            "temperature": SQLITE_TYPE_TEXT,
            "state": SQLITE_TYPE_INTEGER])
    }
    
    @discardableResult public func dropTable(_ tableName: String) -> Bool {
        return SQLiteManager.shared.dropTable(tableName)
    }
    
    @discardableResult public func insertTable(_ item: Any) -> Bool {
        if let product = item as? CartProduct {
            return SQLiteManager.shared.insertTable(TABLE_CART, keyValues: product.keyValues())
        }
        
        return false
    }
    
    @discardableResult public func deleteTable(_ item: Any?) -> Bool {
        if let product = item as? CartProduct {
            return SQLiteManager.shared.deleteTable(TABLE_CART, whereKeyValues: ["id": product.id])
        }
        
        return false
    }
    
    @discardableResult public func updateTable(_ item: Any?) -> Bool {
        if let product = item as? CartProduct {
            return SQLiteManager.shared.updateTable(TABLE_CART, keyValues: product.keyValues(), whereKeyValues: ["id": product.id])
        }
        
        return false
    }
    
    @discardableResult public func queryAll(_ cls: AnyClass, state: State = .prepare) -> [Any]? {
        if cls == CartProduct.self {
            let sql = "SELECT * FROM \'\(TABLE_CART)\' WHERE state = " + String(state.rawValue)
            let result = SQLiteManager.shared.querySql(sql)
            guard let records = result else {
                return nil
            }
            
            var productList = [CartProduct]()
            for record in records {
                let product = CartProduct(record)
                
                productList.append(product)
            }
            
            return productList
        }
        
        return nil
    }
}
