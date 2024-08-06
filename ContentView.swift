//
//  ContentView.swift
//  ListApp
//
//  Created by SHUN SATO on 2024/08/07.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Query private var lists: [ListData]
    @Environment(\.modelContext) private var modelContext
    @State var isShowAddListPresent: Bool = false
    @State var isShowAlert: Bool = false
    @State var isToggleOn: Bool = false
    
    var body: some View {
        NavigationStack {
            List(lists) { list in
                Text(list.text)
                    .swipeActions {
                        Button("Delete", systemImage: "trash", role: .destructive) {
                            modelContext.delete(list)
                        }
                    }
                    .onTapGesture {
                        list.isCheck.toggle()
                    }
                    .strikethrough(list.isCheck)
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    if(!lists.isEmpty) {
                        Button("全て削除") {
                            isShowAlert.toggle()
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        SettingsView(isToggleOn: $isToggleOn)
                    } label: {
                        Image(systemName: "gear")
                            .foregroundColor(.accentColor)
                    }
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    Button(action: {
                        isShowAddListPresent.toggle()
                    }, label: {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                            Text("追加")
                        }
                    })
                    Spacer()
                }
            }
            .sheet(isPresented: $isShowAddListPresent) {
                addListView(isToggleOn: $isToggleOn)
                    .presentationDetents([.height(250)])
            }
            .alert("本当に削除しますか？", isPresented: $isShowAlert) {
                Button("キャンセル",role: .cancel) {}
                Button("削除する",role: .destructive) {
                    lists.forEach { list in
                        modelContext.delete(list)
                    }
                }
            }
            .navigationTitle("リスト")
        }
    }
}


#Preview {
    ContentView()
        .navigationTitle("買い物リスト")
        .modelContainer(for: ListData.self)
}
