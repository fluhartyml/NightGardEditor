//
//  NightGardEditor_DeveloperNotes.swift
//  NightGardEditor
//
//  Created by Michael Fluharty on 2025-11-09.
//

/*

 # NightGardEditor - Comprehensive Developer Documentation

 **Module Name:** NightGardEditor
 **Type:** Swift Package (Reusable Library + Demo App)
 **Version:** 1.0.0 (In Development)
 **Created:** 2025-NOV-09
 **Developer:** Michael Fluharty (michael@fluharty.com)
 **Repository:** https://github.com/fluhartyml/NightGard/Modules/NightGardEditor
 **Status:** 🚧 In Development

 ---

 ## Table of Contents

 1. Project Description
 2. Features & Capabilities
 3. Technical Architecture
 4. API Documentation
 5. Demo Applications
 6. Integration Guide
 7. Build & Deployment
 8. Troubleshooting
 9. Version History

 ---

 ## 1. Project Description

 NightGardEditor is a production-ready Swift package providing rich text editing functionality for macOS applications. It wraps NSTextView with a clean, modern API designed for SwiftUI integration.

 **What It Does:**
 - Rich text editing with NSTextView backend
 - Multiple export formats (.rtf, .html, .txt, .md)
 - Document management (new, open, save, save as)
 - Word and character counting
 - Auto-save functionality
 - Settings persistence

 **Why This Exists:**
 This module was extracted from **Diamond Notes Vault** (2025-11-09) as part of the NightGard Module Library initiative - creating reusable "Lego brick" Swift packages that developers can use to rapidly build applications without reinventing common text editing functionality.

 **Supported Platforms:**
 - macOS 26+ (primary focus)
 - iOS support planned for future releases
 - Swift 6.2+

 ---

 ## 2. Features & Capabilities

 ### Current Features (v1.0.0 - In Development)

 🚧 **Rich Text Editing**
 - NSTextView wrapper for native macOS text editing
 - Full formatting support (bold, italic, underline, fonts, colors)
 - Paragraph styles and alignment
 - Lists (bulleted, numbered)
 - Links and attachments

 🚧 **Document Management**
 - New document creation
 - Open existing documents
 - Save and Save As functionality
 - Local file storage (no cloud)
 - Automatic file naming with timestamps

 🚧 **Export Formats**
 - Rich Text Format (.rtf) - Native format
 - HTML (.html) - Web export
 - Plain Text (.txt) - Simple text
 - Markdown (.md) - Developer-friendly format

 🚧 **Statistics & Metadata**
 - Word count tracking
 - Character count tracking
 - Last saved timestamp
 - Document name display

 🚧 **SwiftUI Integration**
 - @Observable macro for reactive UI updates
 - @MainActor thread safety
 - Real-time statistics updates
 - Settings persistence via UserDefaults

 🚧 **Demo Applications**
 - macOS demo app with "Liquid Glass" dark theme UI
 - Blue neon pen (✒️) branding with cyan gradient glow
 - Settings view for configuration
 - Status bar with document info

 🚧 **Easter Egg**
 Console message: `✒️ NightGard Editor ready to write • www.fluharty.me`

 ### Future Enhancements (Planned)

 🔮 **Advanced Editing Features**
 - Spell checking and grammar
 - Find and replace
 - Version history / document revisions
 - Collaboration features
 - Custom themes and syntax highlighting

 🔮 **Additional Export Formats**
 - PDF export
 - DOCX (Microsoft Word)
 - ODT (OpenDocument)
 - LaTeX

 🔮 **Cloud Integration (Optional)**
 - iCloud Drive support
 - Dropbox integration
 - Google Drive support
 - Note: Local-only remains default

 🔮 **Platform Expansion**
 - iOS/iPadOS support with UITextView
 - Shared codebase with platform-specific adaptations

 🔮 **Developer Experience**
 - Pre-built SwiftUI view components
 - Comprehensive unit test suite
 - Example projects and tutorials

 ---

 ## 3. Technical Architecture

 ### Core Components

 **EditorService.swift** (Planned ~200 lines)
 - Main service class
 - @MainActor @Observable for SwiftUI reactivity
 - Document management methods
 - Export functionality
 - Statistics calculation

 **Key Properties (Planned):**
 ```swift
 public var documentName: String          // Current document name
 public var content: NSAttributedString   // Rich text content
 public var lastSaved: Date?              // Last save timestamp
 public var wordCount: Int                // Calculated word count
 public var characterCount: Int           // Calculated character count
 public var isDirty: Bool                 // Unsaved changes flag
 ```

 ### Document Management Flow (Planned)

 1. New document → Create empty NSAttributedString
 2. User types → Content updates in real-time
 3. Statistics → Calculate words/characters on change
 4. Save → Export to selected format (RTF default)
 5. Auto-save → Periodic background saves
 6. Load → Import from file into NSAttributedString

 ### Export Implementation (Planned)

 **Rich Text Format (.rtf):**
 - NSAttributedString → RTF data
 - Preserves all formatting
 - Native macOS format

 **HTML:**
 - NSAttributedString → HTML with CSS
 - Inline styles for portability
 - Web-compatible output

 **Plain Text:**
 - Strip all formatting
 - Extract raw text only

 **Markdown:**
 - Convert formatting to markdown syntax
 - Bold → **text**, Italic → *text*
 - Headers, lists, links preserved

 ### Thread Safety

 - All public methods marked @MainActor
 - File I/O uses async/await
 - No data races or concurrency issues

 ### Persistence Layer

 UserDefaults keys (Planned):
 - `editor_lastDocument` - String (path)
 - `editor_autoSaveInterval` - Double (seconds)
 - `editor_defaultFormat` - String (rtf/html/txt/md)

 ---

 ## 4. API Documentation

 ### EditorService Class (Planned)

 **Initialization:**
 ```swift
 let editor = EditorService()
 // Automatically loads last document if available
 ```

 **Document Operations:**
 ```swift
 editor.newDocument()                           // Create blank document
 await editor.openDocument(url: URL)            // Open existing file
 await editor.saveDocument()                    // Save to current location
 await editor.saveDocumentAs(url: URL)          // Save to new location
 ```

 **Export Operations:**
 ```swift
 await editor.exportAsRTF(to: URL)              // Export rich text
 await editor.exportAsHTML(to: URL)             // Export HTML
 await editor.exportAsPlainText(to: URL)        // Export plain text
 await editor.exportAsMarkdown(to: URL)         // Export markdown
 ```

 **Observable Properties:**
 ```swift
 editor.documentName                            // String - current doc name
 editor.content                                 // NSAttributedString - rich text
 editor.wordCount                               // Int - word count
 editor.characterCount                          // Int - character count
 editor.lastSaved                               // Date? - last save time
 editor.isDirty                                 // Bool - unsaved changes
 ```

 ### SwiftUI Integration Example (Planned)

 ```swift
 import SwiftUI
 import NightGardEditor

 struct ContentView: View {
     @State private var editorService = EditorService()

     var body: some View {
         VStack {
             // Editor view (NSTextView wrapper)
             EditorView(service: editorService)

             // Status bar
             HStack {
                 Text(editorService.documentName)
                 Spacer()
                 Text("Words: \(editorService.wordCount)")
                 Text("Characters: \(editorService.characterCount)")
             }

             // Toolbar
             HStack {
                 Button("New") { editorService.newDocument() }
                 Button("Save") { Task { await editorService.saveDocument() } }
             }
         }
     }
 }
 ```

 ---

 ## 5. Demo Applications

 ### macOS Demo App (For Human Developers)

 **Location:** `/Users/michaelfluharty/Developer/NightGard/Modules/NightGardEditor/`

 **Files:**
 - `NightGardEditor/ContentView.swift` - Main UI with blue neon pen
 - `NightGardEditor/SettingsView.swift` - Configuration form
 - `NightGardEditor/EditorService.swift` - Core service (copy of package version)
 - `NightGardEditor/NightGardEditorApp.swift` - App entry point

 **Design:**
 - **Theme:** "Liquid Glass" dark mode aesthetic
 - **Icon:** Blue neon pen (✒️) with cyan gradient glow
 - **Background:** Pure black (#000000)
 - **Accents:** Cyan (#00FFFF) for interactive elements
 - **Shadows:** Dual-layer glow effect on pen icon

 **Features (Planned):**
 - Real-time word/character count
 - Document name display
 - Last saved timestamp
 - New Document button
 - Save button
 - Settings sheet for preferences
 - Export options menu

 **Build & Run:**
 1. Open `NightGardEditor.xcodeproj` in Xcode
 2. Select "NightGardEditor" scheme
 3. Build (⌘B) and Run (⌘R)
 4. App requires file access permissions

 **Sandbox Configuration:**
 - App Sandbox: Disabled (GitHub distribution, not App Store)
 - User Selected Files: Read/Write access
 - Downloads Folder: Read/Write (optional)

 ---

 ## 6. Integration Guide

 ### For Swift Package Manager (Planned)

 **Step 1: Add Dependency**
 ```swift
 // Package.swift
 let package = Package(
     name: "YourApp",
     dependencies: [
         .package(
             url: "https://github.com/fluhartyml/NightGard/Modules/NightGardEditor",
             from: "1.0.0"
         )
     ],
     targets: [
         .target(
             name: "YourApp",
             dependencies: ["NightGardEditor"]
         )
     ]
 )
 ```

 **Step 2: Import and Use**
 ```swift
 import NightGardEditor

 @State private var editor = EditorService()

 // Create new document
 editor.newDocument()

 // Save document
 Task {
     await editor.saveDocument()
 }

 // Access statistics
 print("Words: \(editor.wordCount)")
 print("Characters: \(editor.characterCount)")
 ```

 ### For Xcode Projects (Planned)

 **Step 1: Add Package**
 1. File → Add Package Dependencies...
 2. Enter URL: `https://github.com/fluhartyml/NightGard/Modules/NightGardEditor`
 3. Choose version rule: "Up to Next Major" (1.0.0 < 2.0.0)
 4. Add to your target

 **Step 2: Configure Permissions (macOS)**
 1. Select your target → Signing & Capabilities
 2. For App Store: Enable "User Selected File" read/write
 3. For GitHub distribution: Can disable App Sandbox entirely

 **Step 3: Use in Code**
 ```swift
 import SwiftUI
 import NightGardEditor

 @main
 struct MyApp: App {
     @State private var editorService = EditorService()

     var body: some Scene {
         WindowGroup {
             ContentView(editor: editorService)
         }
         .commands {
             CommandGroup(replacing: .newItem) {
                 Button("New Document") {
                     editorService.newDocument()
                 }
                 .keyboardShortcut("n")
             }
         }
     }
 }
 ```

 ---

 ## 7. Build & Deployment

 ### Development Build (Planned)

 ```bash
 # Clone repository
 git clone https://github.com/fluhartyml/NightGard.git
 cd NightGard/Modules/NightGardEditor

 # Build package
 swift build

 # Run tests
 swift test
 ```

 ### Xcode Build

 1. Open `NightGardEditor.xcodeproj`
 2. Select scheme: NightGardEditor
 3. Product → Build (⌘B)
 4. Product → Run (⌘R)

 **Build Configuration:**
 - Swift Language Version: Swift 6
 - Minimum macOS: 26.0
 - App Sandbox: Disabled (self-distribution)

 ### Distribution

 **Via GitHub:**
 - Repository: https://github.com/fluhartyml/NightGard
 - Path: /Modules/NightGardEditor
 - Swift Package Manager compatible
 - DMG installer for demo app
 - No App Store distribution

 **Versioning:**
 - Semantic versioning (MAJOR.MINOR.PATCH)
 - Current: 1.0.0 (in development)
 - Git tags for releases

 ---

 ## 8. Troubleshooting

 ### Common Issues (To Be Documented)

 **Build Errors:**
 - TBD based on development experience

 **Runtime Issues:**
 - TBD based on testing

 **File Access:**
 - Ensure sandbox permissions allow file read/write
 - Check user has permission to access selected directories

 **Performance:**
 - Large documents (100k+ words) may require optimization
 - Consider lazy loading for very large files

 ---

 ## 9. Version History

 ### v1.0.0 (2025-NOV-09) - In Development 🚧

 **Status:** Initial development
 - 🚧 EditorService implementation
 - 🚧 macOS demo app with blue neon pen UI
 - 🚧 Rich text editing with NSTextView
 - 🚧 Export formats (RTF, HTML, TXT, MD)
 - 🚧 Settings persistence
 - 🚧 Easter egg console message

 **Platform:**
 - macOS 26+ primary target
 - iOS support deferred to future release

 **Design Philosophy:**
 - Local-first (no cloud requirement)
 - Self-distribution via GitHub
 - Clean API for easy integration
 - Native macOS feel with modern SwiftUI

 **Contributors:**
 - Michael Fluharty (Architecture, Implementation)
 - Claude AI Assistant (Code generation, Documentation)

 ---

 ## Easter Eggs & Branding

 ✒️ **Console Message (Planned)**
 When editor initializes:
 ```
 ✒️ NightGard Editor ready to write • www.fluharty.me
 ```

 ✒️ **Blue Neon Pen**
 - App icon uses pen/quill (✒️) character
 - Blue to cyan gradient: `[.blue, .cyan]`
 - Dual-layer glow: Blue (0.8 opacity, 20pt radius) + Cyan (0.6 opacity, 40pt radius)
 - Represents creativity and written expression

 🎨 **Liquid Glass Theme**
 - Pure black background (#000000)
 - Cyan accents (#00FFFF)
 - Glass-style buttons with transparency
 - Matches NightGard design language

 ---

 ## Additional Resources

 **NightGard Module Library:**
 - Website: www.fluharty.me
 - Developer: Michael Fluharty
 - Other Modules: NightGardDDNS, NightGardFileSystem

 **Apple Documentation:**
 - NSTextView: https://developer.apple.com/documentation/appkit/nstextview
 - NSAttributedString: https://developer.apple.com/documentation/foundation/nsattributedstring
 - SwiftUI: https://developer.apple.com/documentation/swiftui

 ---

 ## License & Attribution

 **License:** GNU General Public License v3.0 (GPL v3)

 **"Share and Share Alike with Attribution Required"**

 This software is licensed under GPL v3, which means:
 - ✅ You may use, study, modify, and distribute this software freely
 - ✅ Source code must be provided with any distribution
 - ✅ All derivative works must remain open source under GPL v3
 - ✅ Attribution to Michael Fluharty as original author is REQUIRED
 - ✅ All modifications must be documented

 **Required Attribution:**
 When distributing this software or derivatives, you must:
 1. Credit Michael Fluharty as the original author
 2. Include link: https://github.com/fluhartyml
 3. Maintain GPL v3 license documentation intact
 4. Document all changes made

 **Warranty Disclaimer:**
 This software is provided "AS IS" with no warranty of any kind. The author assumes no liability for damages, data loss, or business interruption resulting from use.

 **Full License Text:**
 https://www.gnu.org/licenses/gpl-3.0.en.html

 **EULA:**
 - Web: https://fluharty.me (See wiki for complete EULA)
 - GitHub: https://github.com/fluhartyml/fluhartyml.github.io/wiki/EULA-End-User-License-Agreement

 **Support:**
 - Website: https://fluharty.me
 - GitHub Issues: https://github.com/fluhartyml/NightGard/issues
 - Email: michael@fluharty.com

 ---

 *✒️ NightGard Module Library - Reusable Swift packages for rapid development*
 *www.fluharty.me*

 // ============================================================================
 // MARK: - ABOUT THIS APP
 // ============================================================================
 //
 //  NightGard Editor
 //
 //  Write beautifully.
 //
 //  Engineered with Claude by Anthropic
 //
 //  Copyright (c) 2025 Michael Fluharty
 //  Licensed under Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)
 //  https://creativecommons.org/licenses/by-sa/4.0/
 //
 //  You are free to share and adapt this work under the following terms:
 //  - Attribution: Give appropriate credit, provide a link to the license
 //  - ShareAlike: Distribute contributions under the same license
 //
 //  Website: https://fluharty.me
 //  Contact: michael@fluharty.me
 //  Feedback and suggestions welcome!
 */

// This file exists solely for documentation purposes.
// It is not compiled into the package.
