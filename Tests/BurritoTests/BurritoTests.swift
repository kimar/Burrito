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
