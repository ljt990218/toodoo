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
    var timestamp: Date // 创建时间
    var title: String // 待办事项标题
    var icon: String // SF Symbols 图标名称
    var content: String // 待办事项详细内容
    
    init(timestamp: Date, title: String = "", icon: String = "circle.fill", content: String = "") {
        self.timestamp = timestamp
        self.title = title
        self.icon = icon
        self.content = content
    }
}
