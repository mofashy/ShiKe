//
//  Product.swift
//  ShiKe
//
//  Created by 沈永聪 on 2018/6/8.
//  Copyright © 2018年 沈永聪. All rights reserved.
//

import UIKit

class Product: NSObject, Codable {
    //MARK:- Members
    var coverUrl: String?
    var name: String?
    var price: Int = 0
    var type: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case coverUrl
        case name
        case price
        case type
    }
    
    //MARK:- Life cycle
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        coverUrl = try container.decode(String.self, forKey: .coverUrl)
        name = try container.decode(String.self, forKey: .name)
        price = try container.decode(Int.self, forKey: .price)
        type = try container.decode(Int.self, forKey: .type)
    }
    
    func encode(to encoder: Encoder) throws {
        //FIXME: 处理模型转json
    }
}
