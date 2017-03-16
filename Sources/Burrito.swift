class Burrito<T> {
    static func unwrap(_ object: Any) -> T? {
        return object as? T
    }
    
    static func unwrap(_ object: Any, onOptional: () -> T) -> T {
        return object as? T ?? onOptional()
    }
}

public extension Dictionary where Key: Hashable {
    func unwrap<T>(_ key: Key) -> T? {
        return self[key] as? T
    }
    
    func unwrap<T>(_ key: Key, onOptional: () -> T) -> T {
        return self[key] as? T ?? onOptional()
    }
}
