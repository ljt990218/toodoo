//
//  ContentView.swift
//  toodoo
//
//  Created by SwagLiu on 2025/12/18.
//

import SwiftUI
import SwiftData

// 主视图，显示待办事项列表
struct ContentView: View {
    // 从环境中获取数据上下文，用于增删改数据
    @Environment(\.modelContext) private var modelContext
    // 使用 @Query 自动查询所有 Item 数据，数据变化时视图会自动更新
    @Query private var items: [Item]

    var body: some View {
        // NavigationSplitView 提供主从导航结构（iPad 上会显示分栏）
        NavigationSplitView {
            // 列表视图，显示所有待办事项
            List {
                // 遍历所有项目并显示
                ForEach(items) { item in
                    // NavigationLink 点击后导航到详情页面
                    NavigationLink {
                        // 详情页面显示完整的时间戳
                                Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
                    } label: {
                        // 列表中显示的内容
                        Text("Item as\(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
                    }
                }
                // 启用滑动删除功能
                .onDelete(perform: deleteItems)
            }
            // 工具栏配置
            .toolbar {
                // 右上角的编辑按钮，用于进入编辑模式（可批量删除）
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                // 添加按钮，点击后创建新项目
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        } detail: {
            // 当没有选中任何项目时显示的占位文本
            Text("Select an item")
        }
    }

    // 添加新项目的方法
    private func addItem() {
        // withAnimation 让添加操作带有动画效果
        withAnimation {
            // 创建新的 Item，时间戳为当前时间
            let newItem = Item(timestamp: Date())
            // 将新项目插入到数据上下文中（会自动保存）
            modelContext.insert(newItem)
        }
    }

    // 删除项目的方法，offsets 包含要删除的项目索引
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            // 遍历所有要删除的索引
            for index in offsets {
                // 从数据上下文中删除对应的项目
                modelContext.delete(items[index])
            }
        }
    }
}

// Xcode 预览，用于在开发时实时查看界面效果
#Preview {
    ContentView()
        // inMemory: true 表示预览时数据只存在内存中，不会持久化
        .modelContainer(for: Item.self, inMemory: true)
}
