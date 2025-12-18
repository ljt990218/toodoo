//
//  toodooApp.swift
//  toodoo
//
//  Created by SwagLiu on 2025/12/18.
//

import SwiftUI
import SwiftData

// 应用程序入口点，使用 @main 标记
@main
struct toodooApp: App {
    // 创建 SwiftData 数据容器，用于存储和管理数据
    var sharedModelContainer: ModelContainer = {
        // 定义数据模型架构，包含 Item 模型
        let schema = Schema([
            Item.self,
        ])
        // 配置数据存储方式，isStoredInMemoryOnly: false 表示数据会持久化到磁盘
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            // 如果创建失败，应用程序会崩溃并显示错误信息
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    // 定义应用程序的主界面场景
    var body: some Scene {
        // WindowGroup 是 iOS 应用的标准窗口容器
        WindowGroup {
            ContentView()
        }
        // 将数据容器注入到环境中，使所有子视图都能访问数据
        .modelContainer(sharedModelContainer)
    }
}
