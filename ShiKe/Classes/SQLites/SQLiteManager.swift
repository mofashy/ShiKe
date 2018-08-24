//
//  SQLiteManager.swift
//  ShiKe
//
//  Created by 沈永聪 on 2018/6/14.
//  Copyright © 2018年 沈永聪. All rights reserved.
//

import UIKit
import SQLite3

let SQLITE_NAME = "shike.sqlite"
let SQLITE_TYPE_TIMESTAMP = "TIMESTAMP"
let SQLITE_TYPE_TEXT = "TEXT"
let SQLITE_TYPE_INTEGER = "INTEGER"
let SQLITE_TYPE_DOUBLE = "DOUBLE"

class SQLiteManager: NSObject {
    static let shared = SQLiteManager()
    private var db: OpaquePointer?
    
    private override init() { }
    
    private func sqlitePath() -> String {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! + "/\(SQLITE_NAME)"
        
        return path
    }
    
    @discardableResult private func open() -> Bool {
        if db == nil {
            let path = sqlitePath()
            if sqlite3_open(path.cString(using: .utf8)!, &db) != SQLITE_OK {
                close()
                return false
            } else {
                //
            }
            sqlite3_busy_handler(db, { (ptr, count) in
                usleep(500000)  // 等待0.5s
                return 1    // 不断尝试
            }, &db)
        }
        
        return true
    }
    
    private func close() {
        sqlite3_close(db)
        db = nil
    }
    
    @discardableResult private func execSql(_ sql: String) -> Bool {
        print("\(sql)")
        
        objc_sync_enter(self)
        if !self.open() {
            objc_sync_exit(self)
            return false
        }
        
        var error: UnsafeMutablePointer<Int8>?
        if sqlite3_exec(db, sql.cString(using: .utf8), nil, nil, &error) != SQLITE_OK {
            if let error = String(validatingUTF8: sqlite3_errmsg(db)) {
                print("execute failed, error: \(error)")
            }
            
            objc_sync_exit(self)
            return false
        }
        
        objc_sync_exit(self)
        return true
    }
    
    public func querySql(_ sql: String) -> [[String: Any]]? {
        print("\(sql)")
        objc_sync_enter(self)
        if !self.open() {
            objc_sync_exit(self)
            return nil
        }
        
        var array = [[String: Any]]()
        var statement: OpaquePointer?
        if sqlite3_prepare_v2(db, sql.cString(using: .utf8), -1, &statement, nil) == SQLITE_OK {
            while sqlite3_step(statement) == SQLITE_ROW {
                let columns = sqlite3_column_count(statement)
                var row = [String: Any]()
                for i in 0..<columns {
                    let type = sqlite3_column_type(statement, i)
                    let chars = UnsafePointer<CChar>(sqlite3_column_name(statement, i))
                    let name = String.init(cString: chars!, encoding: .utf8)
                    
                    var value: Any
                    switch type {
                    case SQLITE_INTEGER:
                        value = sqlite3_column_int(statement, i)
                    case SQLITE_FLOAT:
                        value = sqlite3_column_double(statement, i)
                    case SQLITE_TEXT:
                        let chars = UnsafePointer<CUnsignedChar>(sqlite3_column_text(statement, i))
                        value = String.init(cString: chars!)
                    default:
                        value = ""
                    }
                    
                    row.updateValue(value, forKey: "\(name!)")
                }
                
                array.append(row)
            }
        }
        
        sqlite3_finalize(statement)
        
        objc_sync_exit(self)
        if array.count == 0 {
            return nil
        } else {
            return array
        }
    }
    
    public func doTransaction(exec: ((_ db: OpaquePointer) -> ())?) {
        objc_sync_enter(self)
        if !self.open() {
            objc_sync_exit(self)
            return
        }
        
        if exec != nil {
            var error: UnsafeMutablePointer<Int8>?
            if sqlite3_exec(db, "BEGIN TRANSACTION", nil, nil, &error) == SQLITE_OK {
                exec!(db!)
                if sqlite3_exec(db, "COMMIT TRANSACTION", nil, nil, &error) == SQLITE_OK {
                    print("Transaction commit success")
                } else {
                    print("Transaction commit fail: \(String(describing: error))")
                    
                    if sqlite3_exec(db, "ROLLBACK TRANSACTION", nil, nil, &error) == SQLITE_OK {
                        print("Transaction rollback success")
                    }
                }
            } else {
                if sqlite3_exec(db, "ROLLBACK TRANSACTION", nil, nil, &error) == SQLITE_OK {
                    print("Transaction rollback success")
                }
            }
            
            sqlite3_free(error)
        }
        
        objc_sync_exit(self)
    }
}

extension SQLiteManager {
    public func createTable(_ tableName: String, keyValues: [String: String]) -> Bool {
        if keyValues.count == 0 {
            return false
        }
        
        var sql = "CREATE TABLE IF NOT EXISTS \'\(tableName)\' (id INTEGER PRIMARY KEY AUTOINCREMENT, "
        keyValues.keys.forEach { (key) in
            sql += "\'\(key)\' "
            sql += "\(keyValues[key]!), "
        }
//        let range = sql.index(sql.endIndex, offsetBy: -2)..<sql.endIndex
//        sql.replaceSubrange(range, with: ")")
        sql += "logTime timestamp DEFAULT (DATETIME(\'NOW\', \'LOCALTIME\')))"
        
        return self.execSql(sql)
    }
    
    public func dropTable(_ tableName: String) -> Bool {
        let sql = "DROP TABLE IF EXISTS \'\(tableName)\'"
        return self.execSql(sql)
    }
}

extension SQLiteManager {
    public func insertTable(_ tableName: String, keyValues: [String: Any]) -> Bool {
        if keyValues.count == 0 {
            return false
        }
        
        var sql = "INSERT INTO \'\(tableName)\' "
        var keys = "("
        var values = " ("
        keyValues.keys.forEach { (key) in
            keys += "\'\(key)\' ,"
            if let value = keyValues[key] as? String {
                values += "\'\(value)\', "
            } else {
                values += "\(keyValues[key]!), "
            }
        }
        var range = keys.index(keys.endIndex, offsetBy: -2)..<keys.endIndex
        keys.replaceSubrange(range, with: ")")
        range = values.index(values.endIndex, offsetBy: -2)..<values.endIndex
        values.replaceSubrange(range, with: ")")
        sql += "\(keys) VALUES \(values)"
        
        return self.execSql(sql)
    }
    
    public func deleteTable(_ tableName: String, whereKeyValues: [String: Any]) -> Bool {
        if whereKeyValues.count == 0 {
            return false
        }
        
        var sql = "DELETE FROM \'\(tableName)\' WHERE"
        whereKeyValues.keys.forEach({ (key) in
            sql += " \(key) = "
            if  let value = whereKeyValues[key] as? String  {
                sql += " \'\(value)\' and"
            }else {
                sql += " \(whereKeyValues[key]!) and"
            }
        })
        let range = sql.index(sql.endIndex, offsetBy: -4)..<sql.endIndex
        sql.removeSubrange(range)
        
        return self.execSql(sql)
    }
}

extension SQLiteManager {
    public func updateTable(_ tableName: String, keyValues: [String: Any], whereKeyValues: [String: Any]) -> Bool {
        if keyValues.count == 0 {
            return false
        }
        
        var sql = "UPDATE \'\(tableName)\' SET"
        keyValues.keys.forEach({ (key) in
            sql += " \(key) = "
            if  let value = keyValues[key] as? String  {
                sql += " \'\(value)\', "
            }else {
                sql += " \(keyValues[key]!), "
            }
        })
//        var range = sql.index(sql.endIndex, offsetBy: -2)..<sql.endIndex
//        sql.removeSubrange(range)
        
        sql += " logTime = (DATETIME(\'NOW\', \'LOCALTIME\'))"
        
        sql += " WHERE"
        whereKeyValues.keys.forEach { (key) in
            sql += " \(key) = "
            if  let value = whereKeyValues[key] as? String  {
                sql += " \'\(value)\', "
            }else {
                sql += " \(whereKeyValues[key]!), "
            }
        }
        let range = sql.index(sql.endIndex, offsetBy: -2)..<sql.endIndex
        sql.removeSubrange(range)
        
        return self.execSql(sql)
    }
}
