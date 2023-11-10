//

import SwiftUI

extension Binding {
    func unwrapped<Wrapped>() -> Binding<Wrapped>? where Value == Wrapped? {
        guard let wrappedValue else { return nil }
        return Binding<Wrapped>(get: {
            wrappedValue
        }, set: { newValue in
            self.wrappedValue = newValue
        })

    }
    
    func map<T>(_ to: @escaping (Value) -> T, from: @escaping (T) -> Value) -> Binding<T> {
        Binding<T>(get: {
            to(wrappedValue)
        }, set: {
            wrappedValue = from($0)
        })
    }
}
