//

import SwiftUI

struct DocumentViewer: View {
    @Bindable var document: Document
    
    var body: some View {
        let _ = Self._printChanges()
        Form {
            VStack(alignment: .leading) {
                Text(document.id.uuidString)
                    .font(.caption)
                HStack(spacing: 6) {
                    if document.isFavourite {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                            .font(.caption)
                    }
                    TextField("title", text: $document.title)
                }
            }
        }
    }
}

#Preview {
    DocumentViewer(document: Document(template: .creditCard))
}
