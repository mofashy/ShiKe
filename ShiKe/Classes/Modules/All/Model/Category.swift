//
//  Category.swift
//  ShiKe
//
//  Created by 沈永聪 on 2018/6/8.
//  Copyright © 2018年 沈永聪. All rights reserved.
//

import UIKit

class Category: NSObject, Codable {
    //MARK:- Members
    var title: String?
    var detail: String?
    var productList: [Product]?
    
    enum CodingKeys: String, CodingKey {
        case title
        case detail
        case productList
    }
    
    //MARK:- Life cycle
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        detail = try container.decode(String.self, forKey: .detail)
        productList = try container.decode([Product].self, forKey: .productList)
    }
    
    func encode(to encoder: Encoder) throws {
        //FIXME: 处理模型转json
    }
}
