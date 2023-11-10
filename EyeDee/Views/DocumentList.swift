//

import SwiftUI

struct DocumentList: View {
    @Bindable var viewModel: ViewModel
    
    var body: some View {
        let _ = Self._printChanges()
        List(selection: $viewModel.selectedDocument) {
            ForEach($viewModel.documents, id:\.self) { document in
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
                        document.isFavourite.wrappedValue = !document.isFavourite.wrappedValue
                    }
                    .tint(.yellow)
                }
            }
            .onDelete(perform: { indexSet in
                indexSet.forEach {
                    if viewModel.selectedDocument == viewModel.documents[$0] {
                        viewModel.selectedDocument = nil
                    }
                    viewModel.documents.remove(at: $0)
                }
            })
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Menu("", systemImage: "plus") {
                    ForEach(Template.allCases, id: \.self) { template in
                        Button(template.defaultTitle) {
                            let document = Document(template: template)
                            viewModel.documents.append(document)
                            viewModel.selectedDocument = document
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        DocumentList(viewModel: ViewModel())
    }
}
