//
//  Item.swift
//  toodoo
//
//  Created by SwagLiu on 2025/12/18.
//

import Foundation
import SwiftData

// @Model 宏将这个类标记为 SwiftData 数据模型，自动处理持久化
@Model
final class Item {
    // 存储项目创建的时间戳
    var timestamp: Date
    
    // 初始化方法，创建新项目时需要传入时间戳
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
