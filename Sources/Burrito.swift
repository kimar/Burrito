import Foundation

public typealias 🌯<T> = Burrito<T>
public class Burrito<T> {
    static func unwrap(_ object: Any) -> T? {
        return object as? T
    }
    
    static func unwrap(_ object: Any, onOptional: () -> T) -> T {
        return unwrap(object) ?? onOptional()
    }
}

// MARK: - Extensions
public extension Dictionary {
    func either<T>(_ key: Key) -> T? {
        return self[key] as? T
    }
    
    func either<T>(_ key: Key, onOptional: () -> T) -> T {
        return either(key) ?? onOptional()
    }
}

public extension String {
    func eitherUrl() -> URL? {
        return URL(string: self)
    }
    
    func eitherUrl(_ onOptional: () -> URL) -> URL {
        return eitherUrl() ?? onOptional()
    }
}

// MARK: - Operators
infix operator <~>
public func <~><T>(lhs: T?, rhs: () -> T) -> T {
    return lhs ?? rhs()
}

public func <~><T>(lhs: T?, rhs: T) -> T {
    return lhs ?? rhs
}
