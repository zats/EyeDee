//

import SwiftUI

@main
struct EyeDeeApp: App {
    @State private var document: [Document] = []
    @State private var selectedDocument: Document?

    var body: some Scene {
        WindowGroup {
            ContentView(
                documents: $document,
                selectedDocument: $selectedDocument
            )
        }
    }
}
