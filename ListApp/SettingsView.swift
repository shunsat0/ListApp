//
//  SettingsView.swift
//  ListApp
//
//  Created by SHUN SATO on 2024/08/07.
//

import SwiftUI
import WebUI

struct SettingsView: View {
    @Binding var isToggleOn:Bool
    
    var body: some View {
        List {
            Section(header: Text("AIリコメンド")) {
                HStack {
                    Toggle("AIリコメンド", isOn: $isToggleOn)
                        .onChange(of: isToggleOn) {
                            print(isToggleOn)
                        }
                }
            }
            
            Section(header: Text("ご利用にあたって")) {
                Text("[利用規約](https://shunsato.me/privacy-policy/list/terms.html)")
                Text("[プライバシーポリシー](https://shunsato.me/privacy-policy/list/policy.html)")
            }
            
            Section(header: Text("お問い合わせ")) {
                Text("[X(旧Twitter)](https://x.com/shunsat0)")
            }
            
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    SettingsView(isToggleOn: .constant(true))
}
