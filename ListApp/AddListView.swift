//
//  AddListView.swift
//  ListApp
//
//  Created by SHUN SATO on 2024/08/07.
//
import SwiftUI
import SwiftData
import GoogleGenerativeAI

struct addListView: View {
    @Query private var lists: [ListData]
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @State var inputText:String = ""
    @FocusState var focus:Bool
    @State var recommend:String = ""
    @Binding var isToggleOn:Bool
    @State var isProgress: Bool = false
    
    
    func getEnvironmentVar(_ key: String) -> String? {
        guard let value = ProcessInfo.processInfo.environment[key] else {
            print("Error: Environment variable \(key) not set")
            return nil
        }
        return value
    }

    
    private func add() {
        let newList = ListData(text: inputText)
        modelContext.insert(newList)
        dismiss()
    }
    
    private func cancel() {
        dismiss()
    }
    
    private func gemini(prompt:String) async throws -> String {
        let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String ?? "default_key"
        
        let model = GenerativeModel(name: "gemini-1.5-pro", apiKey: apiKey)
        
        let order = "\(prompt)に合うメニューを一つだけピックアップして、メニュー名と簡単なコメントを添付して下さい。マークダウンではなく、プレーンテキストでお願いします。「メニュー:」「コメント:」というタイトルは不要です。メニュータイトルには「」をつけて下さい。\(prompt)が食品以外の場合は、「食品以外はおすすめを表示できません！」という文章を返してください。"
        
        isProgress.toggle()
        do {
            let result = try await model.generateContent(order)
            
            isProgress.toggle()
            
            return result.text ?? "No Response found"
        } catch {
            return "エラーが発生しました。しばらく時間をおいてから、入力してください😢"
        }
    }
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("買うもの", text:$inputText)
                    .focused($focus)
                    .onSubmit {
                        if(isToggleOn) {
                            Task {
                                do {
                                    let response = try await gemini(prompt: inputText)
                                    recommend = response
                                    print("Response: \(response)")
                                } catch {
                                    print("Error occurred: \(error.localizedDescription)")
                                }
                            }
                        }
                    }
                    .submitLabel(.done)
                
                if recommend.isEmpty && isProgress {
                    ProgressView()
                } else if !recommend.isEmpty {
                    Text(recommend)
                }
            }
            .navigationTitle("新しいリストを追加")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(action: cancel) {
                        Text("キャンセル")
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button(action: add) {
                        Text("追加")
                    }
                    .disabled(inputText.isEmpty)
                }
            }
        }
        .onTapGesture {
            focus = false
        }
    }
}

#Preview {
    addListView(isToggleOn: .constant(true))
}
