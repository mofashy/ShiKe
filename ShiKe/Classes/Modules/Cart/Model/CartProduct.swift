//
//  CartProduct.swift
//  ShiKe
//
//  Created by 沈永聪 on 2018/6/9.
//  Copyright © 2018年 沈永聪. All rights reserved.
//

import UIKit

enum Capacity: String, Codable {
    // 小杯、中杯、大杯、超大杯
//    case short
    case tall
    case grande
    case venti
}

enum Sugariness: String, Codable {
    // 无糖(正常)、少糖、半糖、全糖
    case free
    case less
    case semi
//    case total
}

enum Temperature: String, Codable {
    // 正常、加冰、热
    case free
    case less
    case hot
}

@objcMembers class CartProduct: BaseObject, Codable {
    //MARK:- Members
    var id: Int = 0
    var isCheck = false
    var coverUrl: String?
    var name: String?
    var price = 0
    var logTime: String?
    @objc dynamic var quantity = 0 {
        didSet {
            quantity = max(1, quantity)
        }
    }
    var capacity: Capacity = .tall
    var sugariness: Sugariness = .less
    var temperature: Temperature = .less
    var state: State = .prepare
    
    enum CodingKeys: String, CodingKey {
        case isCheck
        case coverUrl
        case name
        case capacity
        case sugariness
        case temperature
        case price
        case quantity
        case logTime
        case state
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        isCheck = try container.decode(Bool.self, forKey: .isCheck)
        coverUrl = try container.decode(String.self, forKey: .coverUrl)
        name = try container.decode(String.self, forKey: .name)
        price = try container.decode(Int.self, forKey: .price)
        quantity = try container.decode(Int.self, forKey: .quantity)
        capacity = try container.decode(Capacity.self, forKey: .capacity)
        sugariness = try container.decode(Sugariness.self, forKey: .sugariness)
        temperature = try container.decode(Temperature.self, forKey: .temperature)
        logTime = try container.decode(String.self, forKey: .logTime)
        state = try container.decode(State.self, forKey: .state)
    }
    
    required override init() {
        super.init()
    }
    
    func encode(to encoder: Encoder) throws {
        //FIXME: 处理模型转json
    }
    
    override func expectKeys() -> [String]? {
        return ["id", "logTime", "isCheck"]
    }
}

extension CartProduct {
    override func value(forUndefinedKey key: String) -> Any? {
        if key == CodingKeys.capacity.rawValue {
            return capacity.rawValue
        } else if key == CodingKeys.sugariness.rawValue {
            return sugariness.rawValue
        } else if key == CodingKeys.temperature.rawValue {
            return temperature.rawValue
        } else if key == CodingKeys.state.rawValue {
            return state.rawValue
        } else {
            return nil
        }
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        if key == CodingKeys.capacity.rawValue {
            capacity = Capacity(rawValue: value as! String)!
        } else if key == CodingKeys.sugariness.rawValue {
            sugariness = Sugariness(rawValue: value as! String)!
        } else if key == CodingKeys.temperature.rawValue {
            temperature = Temperature(rawValue: value as! String)!
        } else if key == CodingKeys.state.rawValue {
            state = State(rawValue: value as! Int)!
        } else {
            print("set value for undefined key: \(key)")
        }
    }
}
