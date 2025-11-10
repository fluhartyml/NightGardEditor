//
//  EditorService.swift
//  NightGardEditor
//
//  Created by Michael Fluharty on 11/9/25.
//

import Foundation
import AppKit
import Observation

@Observable
@MainActor
class EditorService {
    var documentText: NSAttributedString = NSAttributedString()
    var documentTitle: String = "Untitled"
    var lastSaved: Date?
    var isBold: Bool = false
    var isItalic: Bool = false
    var isUnderlined: Bool = false
    var currentFontSize: CGFloat = 14.0

    // Stats
    var wordCount: Int {
        let words = documentText.string.components(separatedBy: .whitespacesAndNewlines)
        return words.filter { !$0.isEmpty }.count
    }

    var characterCount: Int {
        return documentText.string.count
    }

    init() {}

    func updateText(_ text: NSAttributedString) {
        documentText = text
    }

    func toggleBold() {
        isBold.toggle()
    }

    func toggleItalic() {
        isItalic.toggle()
    }

    func toggleUnderline() {
        isUnderlined.toggle()
    }

    func changeFontSize(_ size: CGFloat) {
        currentFontSize = size
    }

    func saveDocument() {
        lastSaved = Date()
        print("💾 Document saved: \(documentTitle)")
    }

    func newDocument() {
        documentText = NSAttributedString()
        documentTitle = "Untitled"
        lastSaved = nil
    }
}
