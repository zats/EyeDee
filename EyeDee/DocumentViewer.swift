//

import SwiftUI

struct DocumentViewer: View {
    @Binding var document: Document
    
    var body: some View {
        let _ = Self._printChanges()
        Form {
            VStack(alignment: .leading) {
                Text(document.id.uuidString)
                    .font(.caption)
                TextField("title", text: $document.title)
            }
        }
    }
}

#Preview {
    DocumentViewer(document: .constant(Document(template: .creditCard)))
}
