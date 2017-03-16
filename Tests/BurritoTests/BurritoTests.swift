import XCTest
@testable import Burrito

class BurritoTests: XCTestCase {
    let strings = [
        "nonOptional": "Hello, World!"
    ]
    
    func testDictionaryNonOptionalString() {
        XCTAssertEqual(
            strings.either("nonOptional"), "Hello, World!"
        )
    }
    
    func testDictionaryOptionalString() {
        XCTAssertNil(
            strings.either("optional")
        )
    }
    
    func testDictionaryOptionalStringWithDefault() {
        XCTAssertEqual(
            strings.either("optional") { "👋" }, "👋"
        )
    }
    
    func testStringUnwrapIntWithoutDefault() {
        XCTAssertNil(
            Burrito<String>.unwrap(0)
        )
    }
    
    func testStringUnwrapStringWithoutDefault() {
        XCTAssertEqual(
            Burrito<String>.unwrap("Hello, World!"), "Hello, World!"
        )
    }
    
    func testIntUnwrapIntWithoutDefault() {
        XCTAssertEqual(
            Burrito<Int>.unwrap(0), 0
        )
    }
    
    func testStringUnwrapIntWithDefault() {
        XCTAssertEqual(
            Burrito<String>.unwrap(0) { "Hello, World!" }, "Hello, World!"
        )
    }
    
    func testIntUnwrapStringWithDefault() {
        XCTAssertEqual(
            Burrito<Int>.unwrap("Hello, World!") { 0 }, 0
        )
    }
    
    func testUrlUnwrapUrl() {
        XCTAssertEqual(
            "https://github.com".eitherUrl(), URL(string: "https://github.com")!
        )
    }
    
    func testUrlUnwrapStringWithDefault() {
        XCTAssertEqual(
            "Hello, World!".eitherUrl { URL(string: "https://github.com")! }, URL(string: "https://github.com")!
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
            name: json.either("name") <~> { "Unknown" }, // -> Marcus
            age: json.either("age") <~> -1, // -> 31
            github: json.either("github") {
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
            ("testDictionaryOptionalStringWithDefault", testDictionaryOptionalStringWithDefault),
            ("testStringUnwrapIntWithoutDefault", testStringUnwrapIntWithoutDefault),
            ("testStringUnwrapStringWithoutDefault", testStringUnwrapStringWithoutDefault),
            ("testIntUnwrapIntWithoutDefault", testIntUnwrapIntWithoutDefault),
            ("testStringUnwrapIntWithDefault", testStringUnwrapIntWithDefault),
            ("testIntUnwrapStringWithDefault", testIntUnwrapStringWithDefault),
            ("testPayloadUnwrap", testPayloadUnwrap),
        ]
    }
}
