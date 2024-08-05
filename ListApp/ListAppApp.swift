//
//  ListAppApp.swift
//  ListApp
//
//  Created by SHUN SATO on 2024/08/05.
//

import SwiftUI
import SwiftData

@main
struct ListAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: ListData.self)
        }
    }
}
