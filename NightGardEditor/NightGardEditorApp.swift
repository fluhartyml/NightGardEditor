//
//  NightGardEditorApp.swift
//  NightGardEditor
//
//  Created by Michael Fluharty on 11/9/25.
//

import SwiftUI

@main
struct NightGardEditorApp: App {
    @State private var editorService = EditorService()

    var body: some Scene {
        WindowGroup {
            ContentView(editorService: $editorService)
                .frame(minWidth: 800, minHeight: 600)
        }
        .windowStyle(.hiddenTitleBar)
        .commands {
            CommandGroup(replacing: .newItem) {}
        }
    }
}
