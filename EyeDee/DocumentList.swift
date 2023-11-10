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
                    HStack(spacing: 6) {
                        if document.wrappedValue.isFavourite {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                                .font(.caption)
                        }
                        Text(document.wrappedValue.title)
                    }
                    Text(document.id.uuidString)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .truncationMode(.tail)
                        .lineLimit(1)
                }
                .swipeActions(edge: .leading, allowsFullSwipe: true) {
                    Button("Favourite", systemImage: "star") {
                        document.isFavourite.wrappedValue = !document.wrappedValue.isFavourite
                    }
                    .tint(.yellow)
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
