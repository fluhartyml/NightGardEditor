//
//  SettingsView.swift
//  NightGardEditor
//
//  Created by Michael Fluharty on 11/9/25.
//

import SwiftUI

struct SettingsView: View {
    @Binding var editorService: EditorService
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            Form {
                Section("Editor Configuration") {
                    TextField("Document Title", text: $editorService.documentTitle)
                        .textContentType(.none)
                        .autocorrectionDisabled()

                    Stepper("Font Size: \(Int(editorService.currentFontSize))pt",
                            value: $editorService.currentFontSize,
                            in: 8...72,
                            step: 1)

                    Toggle("Bold", isOn: $editorService.isBold)
                    Toggle("Italic", isOn: $editorService.isItalic)
                    Toggle("Underline", isOn: $editorService.isUnderlined)
                }

                Section("About") {
                    LabeledContent("Version", value: "1.0.0")
                    LabeledContent("Type", value: "Rich Text Editor")
                    Link("www.fluharty.me", destination: URL(string: "https://www.fluharty.me")!)
                }
            }
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    SettingsView(editorService: .constant(EditorService()))
}
