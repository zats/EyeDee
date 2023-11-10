//

import SwiftUI

struct DocumentList: View {
    @Binding var documents: [Document]
    @Binding var selectedDocument: Document?
    
    var body: some View {
        let _ = Self._printChanges()
        List(selection: $selectedDocument) {
            ForEach($documents, id:\.self) { document in
                VStack(alignment: .leading) {
                    Text(document.wrappedValue.title)
                    Text(document.wrappedValue.id.uuidString)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .truncationMode(.tail)
                        .lineLimit(1)
                }
            }
            .onDelete(perform: { indexSet in
                indexSet.forEach {
                    if selectedDocument == documents[$0] {
                        selectedDocument = nil
                    }
                    documents.remove(at: $0)
                }
            })
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Menu("", systemImage: "plus") {
                    ForEach(Template.allCases, id: \.self) { template in
                        Button(template.defaultTitle) {
                            let document = Document(template: template)
                            documents.append(document)
                            selectedDocument = document
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        DocumentList(
            documents: .constant([
                Document(template: .login),
                Document(template: .creditCard),
            ]),
            selectedDocument: .constant(nil)
        )
    }
}
