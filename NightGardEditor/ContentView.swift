//
//  ContentView.swift
//  NightGardEditor
//
//  Created by Michael Fluharty on 11/9/25.
//

import SwiftUI

struct ContentView: View {
    @Binding var editorService: EditorService
    @State private var showSettings = false

    var body: some View {
        ZStack {
            // Liquid Glass Background
            LinearGradient(
                colors: [
                    Color(red: 0.05, green: 0.05, blue: 0.15),
                    Color(red: 0.1, green: 0.1, blue: 0.2)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 30) {
                // Blue Neon Pen Icon
                Text("✒️")
                    .font(.system(size: 80))
                    .shadow(color: .cyan.opacity(0.8), radius: 20)
                    .shadow(color: .blue.opacity(0.6), radius: 40)
                    .padding(.top, 20)

                // Status Display
                VStack(spacing: 15) {
                    StatusRow(label: "Document", value: editorService.documentTitle)
                    StatusRow(label: "Words", value: "\(editorService.wordCount)")
                    StatusRow(label: "Characters", value: "\(editorService.characterCount)")
                    StatusRow(label: "Last Saved", value: formattedLastSaved)
                }
                .padding(.horizontal, 40)

                // Control Buttons
                HStack(spacing: 20) {
                    Button("Settings") {
                        showSettings = true
                    }
                    .buttonStyle(GlassButtonStyle())

                    Button("New Document") {
                        editorService.newDocument()
                    }
                    .buttonStyle(GlassButtonStyle())

                    Button("Save") {
                        editorService.saveDocument()
                    }
                    .buttonStyle(GlassButtonStyle(color: .green))
                }
                .padding(.bottom, 30)

                Spacer()
            }
        }
        .sheet(isPresented: $showSettings) {
            SettingsView(editorService: $editorService)
        }
    }

    var formattedLastSaved: String {
        guard let date = editorService.lastSaved else { return "Never" }
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

struct StatusRow: View {
    let label: String
    let value: String

    var body: some View {
        HStack {
            Text(label + ":")
                .foregroundColor(.gray)
                .frame(width: 120, alignment: .trailing)

            Spacer()

            Text(value)
                .foregroundColor(.cyan)
                .fontWeight(.medium)
        }
        .font(.system(size: 14, design: .monospaced))
        .padding(.vertical, 8)
        .padding(.horizontal, 20)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.white.opacity(0.05))
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.cyan.opacity(0.2), lineWidth: 1)
                )
        )
    }
}

struct GlassButtonStyle: ButtonStyle {
    var color: Color = .cyan

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.horizontal, 24)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(color.opacity(configuration.isPressed ? 0.3 : 0.2))
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(color.opacity(0.5), lineWidth: 1)
                    )
            )
            .foregroundColor(color)
            .fontWeight(.semibold)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}

#Preview {
    ContentView(editorService: .constant(EditorService()))
}
