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
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    @State private var showingAddSheet = false
    @State private var newItemTitle = ""
    @State private var newItemIcon = "circle.fill"
    @State private var newItemContent = ""

    var body: some View {
        // NavigationSplitView 提供主从导航结构（iPad 上会显示分栏）
        NavigationSplitView {
            // 列表视图，显示所有待办事项
            List {
                // 遍历所有项目并显示
                ForEach(items) { item in
                    // NavigationLink 点击后导航到详情页面
                    NavigationLink {
                        VStack(spacing: 20) {
                            Image(systemName: item.icon)
                                .font(.system(size: 60))
                                .foregroundColor(.blue)
                            Text(item.title)
                                .font(.title)
                            Text(item.content)
                                .font(.body)
                            Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        .padding()
                    } label: {
                        HStack {
                            Image(systemName: item.icon)
                                .foregroundColor(.blue)
                            VStack(alignment: .leading) {
                                Text(item.title)
                                    .font(.headline)
                                Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                        }
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
                ToolbarItem {
                    Button(action: { showingAddSheet = true }) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        } detail: {
            Text("Select an item")
        }
        .sheet(isPresented: $showingAddSheet) {
            NavigationView {
                Form {
                    Section("图标") {
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 50))]) {
                            ForEach(["circle.fill", "star.fill", "heart.fill", "flag.fill", "bookmark.fill", "bell.fill", "tag.fill", "paperplane.fill"], id: \.self) { icon in
                                Image(systemName: icon)
                                    .font(.title2)
                                    .foregroundColor(newItemIcon == icon ? .blue : .gray)
                                    .frame(width: 50, height: 50)
                                    .onTapGesture {
                                        newItemIcon = icon
                                    }
                            }
                        }
                    }
                    Section("标题") {
                        TextField("标题", text: $newItemTitle)
                    }
                    Section("内容") {
                        TextField("内容", text: $newItemContent, axis: .vertical)
                            .lineLimit(3...6)
                    }
                }
                .navigationTitle("新建待办")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("取消") {
                            showingAddSheet = false
                            newItemTitle = ""
                            newItemIcon = "circle.fill"
                            newItemContent = ""
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("确认") {
                            addItem()
                            showingAddSheet = false
                        }
                        .disabled(newItemTitle.isEmpty)
                    }
                }
            }
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date(), title: newItemTitle, icon: newItemIcon, content: newItemContent)
            modelContext.insert(newItem)
            newItemTitle = ""
            newItemIcon = "circle.fill"
            newItemContent = ""
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
