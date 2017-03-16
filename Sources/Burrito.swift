import Foundation

class Burrito<T> {
    static func unwrap(_ object: Any) -> T? {
        return object as? T
    }
    
    static func unwrap(_ object: Any, onOptional: () -> T) -> T {
        return unwrap(object) ?? onOptional()
    }
}

public extension Dictionary where Key: Hashable {
    func unwrap<T>(_ key: Key) -> T? {
        return self[key] as? T
    }
    
    func unwrap<T>(_ key: Key, onOptional: () -> T) -> T {
        return self.unwrap(key) ?? onOptional()
    }
}

public extension String {
    func unwrapUrl() -> URL? {
        return URL(string: self)
    }
    
    func unwrapUrl(_ onOptional: () -> URL) -> URL {
        return self.unwrapUrl() ?? onOptional()
    }
}
