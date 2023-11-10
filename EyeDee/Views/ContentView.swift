//

import SwiftUI

struct ContentView: View {
    @Bindable var viewModel: ViewModel
    
    @State private var columnVisibility: NavigationSplitViewVisibility = .all
    
    var body: some View {
        let _ = Self._printChanges()
        NavigationSplitView(columnVisibility: $columnVisibility) {
            DocumentList(viewModel: viewModel)
        } detail: {
            if let document = viewModel.selectedDocument {
                DocumentViewer(document: document)
            } else {
                Text("No document selected")
            }
        }
        .navigationSplitViewStyle(.balanced)
    }

}

#Preview {
    ContentView(viewModel: ViewModel())
}
