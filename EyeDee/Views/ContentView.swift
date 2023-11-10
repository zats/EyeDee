//

import SwiftUI

struct ContentView: View {
    @Binding var documents: [Document]
    @Binding var selectedDocument: Document?
    
    @State private var columnVisibility: NavigationSplitViewVisibility = .all
    
    var body: some View {
        let _ = Self._printChanges()
        NavigationSplitView(columnVisibility: $columnVisibility) {
            DocumentList(documents: $documents, selectedDocument: $selectedDocument)
        } detail: {
            if let selectedDocument = $selectedDocument.unwrapped() {
                DocumentViewer(document: selectedDocument)
            } else {
                Text("No document selected")
            }
        }
        .navigationSplitViewStyle(.balanced)
    }

}

#Preview {
    ContentView(documents: .constant([
        Document(template: .creditCard),
        Document(template: .login),
    ]), selectedDocument: .constant(nil))
}
