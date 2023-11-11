//

import Foundation

@Observable
final class Document: Identifiable, Hashable {
    static func == (lhs: Document, rhs: Document) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    let id: UUID
    
    var title: String
    
    var rows: [Row]
    
    var isFavourite: Bool
    
    init(id: UUID = UUID(), title: String, rows: [Row], isFavourite: Bool) {
        self.id = id
        self.title = title
        self.rows = rows
        self.isFavourite = isFavourite
    }
}

@Observable
final class Row: Identifiable, Hashable {
    static func == (lhs: Row, rhs: Row) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    let id: UUID
    var title: String
    var value: Value
    
    init(id: UUID = UUID(), title: String = "", value: Value = .text("", type: .plain)) {
        self.id = id
        self.title = title
        self.value = value
    }
}

enum Value: Hashable {
    enum TextType: Hashable {
        case plain
        case password
        case number
    }
    
    case text(String, type: TextType = .plain)
}

enum Template: CaseIterable {
    case login
    case creditCard
    
    var defaultTitle: String {
        switch self {
        case .creditCard:
            "Credit card"
        case .login:
            "Login"
        }
    }
    
    var defaultRows: [Row] {
        switch self {
        case .login:
            [
                Row(title: "Username", value: .text("", type: .plain)),
                Row(title: "Password", value: .text("", type: .password)),
            ]
        case .creditCard:
            [
                Row(title: "Card number", value: .text("", type: .number)),
                Row(title: "Expiration date", value: .text("", type: .plain)),
                Row(title: "Name on card", value: .text("", type: .plain)),
                Row(title: "CCV", value: .text("", type: .password)),
            ]
        }
    }
}

extension Document {
    convenience init(template: Template) {
        self.init(
            title: template.defaultTitle,
            rows: template.defaultRows,
            isFavourite: false
        )
    }
}
