//
//  ListData.swift
//  ListApp
//
//  Created by SHUN SATO on 2024/08/07.
//

import Foundation
import SwiftData

@Model
class ListData {
    var text: String
    var isCheck: Bool = false

    init(text: String) {
        self.text = text
    }
}
