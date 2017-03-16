import XCTest
@testable import Burrito

class BurritoTests: XCTestCase {
    let strings = [
        "nonOptional": "Hello, World!"
    ]
    
    func testDictionaryNonOptionalString() {
        XCTAssertEqual(
            strings.unwrap("nonOptional"), "Hello, World!"
        )
    }
    
    func testDictionaryOptionalString() {
        XCTAssertNil(
            strings.unwrap("optional")
        )
    }
    
    func testDictionaryOptionalStringWithFallback() {
        XCTAssertEqual(
            strings.unwrap("optional") { "👋" }, "👋"
        )
    }
    
    func testStringUnwrapIntWithoutFallback() {
        XCTAssertNil(
            Burrito<String>.unwrap(0)
        )
    }
    
    func testStringUnwrapStringWithoutFallback() {
        XCTAssertEqual(
            Burrito<String>.unwrap("Hello, World!"), "Hello, World!"
        )
    }
    
    func testIntUnwrapIntWithoutFallback() {
        XCTAssertEqual(
            Burrito<Int>.unwrap(0), 0
        )
    }
    
    func testStringUnwrapIntWithFallback() {
        XCTAssertEqual(
            Burrito<String>.unwrap(0) { "Hello, World!" }, "Hello, World!"
        )
    }
    
    func testIntUnwrapStringWithFallback() {
        XCTAssertEqual(
            Burrito<Int>.unwrap("Hello, World!") { 0 }, 0
        )
    }
    
    func testUrlUnwrapUrl() {
        XCTAssertEqual(
            "https://github.com".unwrapUrl(), URL(string: "https://github.com")!
        )
    }
    
    func testUrlUnwrapStringWithFallback() {
        XCTAssertEqual(
            "Hello, World!".unwrapUrl { URL(string: "https://github.com")! }, URL(string: "https://github.com")!
        )
    }
    
    func testPayloadUnwrap() {
        
        struct Marcus {
            let name: String
            let age: Int
            let github: URL
        }
        
        let json: [String: Any?] = [
            "name": Optional("Marcus"),
            "age": 31,
            "blog": URL(string: "https://blog.kida.io")!
        ]
        
        let himself = Marcus(
            name: json.unwrap("name") { "Unknown" }, // -> Marcus
            age: json.unwrap("age") { -1 }, // -> 31
            github: json.unwrap("github") {
                URL(string: "https://github.com/kimar")!
            } // -> https://github.com/kimar
        )
        
        XCTAssertEqual(himself.name, "Marcus")
        XCTAssertEqual(himself.age, 31)
        XCTAssertEqual(himself.github, URL(string: "https://github.com/kimar")!)
    }
    
    static var allTests : [(String, (BurritoTests) -> () throws -> Void)] {
        return [
            ("testNonOptionalString", testDictionaryNonOptionalString),
            ("testOptionalString", testDictionaryOptionalString),
            ("testDictionaryOptionalStringWithFallback", testDictionaryOptionalStringWithFallback),
            ("testStringUnwrapIntWithoutFallback", testStringUnwrapIntWithoutFallback),
            ("testStringUnwrapStringWithoutFallback", testStringUnwrapStringWithoutFallback),
            ("testIntUnwrapIntWithoutFallback", testIntUnwrapIntWithoutFallback),
            ("testStringUnwrapIntWithFallback", testStringUnwrapIntWithFallback),
            ("testIntUnwrapStringWithFallback", testIntUnwrapStringWithFallback),

        ]
    }
}
