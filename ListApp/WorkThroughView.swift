//
//  WorkThroughView.swift
//  ListApp
//
//  Created by SHUN SATO on 2024/08/05.
//

import SwiftUI

struct WorkThroughView: View {
    @Environment(\.dismiss) private var dismiss
    let images: [String] = ["追加","設定","AIリコメンド"]
    let text:[String] = ["シンプルな操作","AIをオンにする","AIによるオススメの表示"]
    
    var body: some View {
        TabView {
            ForEach(0...images.count, id: \.self) { index in
                VStack {
                    if(index < images.count) {
                        Text(text[index])
                            .font(.title.bold())
                            .foregroundStyle(Color.blue)
                            .padding()

                        Image("\(images[index])")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 600)

                    } else {
                        Button(action: {
                            dismiss()
                        }) {
                            Text("はじめる")
                                .frame(width: 200, height: 50)
                        }
                        .accentColor(Color.white)
                        .background(Color.blue)
                        .cornerRadius(10.0)
                    }
                }
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
    }
}

#Preview {
    WorkThroughView()
}
