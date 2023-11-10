//

import SwiftUI

@Observable
final class ViewModel {
    var documents: [Document] = []
    var selectedDocument: Document?
}

@main
struct EyeDeeApp: App {
    @State private var viewModel = ViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: viewModel)
        }
    }
}
