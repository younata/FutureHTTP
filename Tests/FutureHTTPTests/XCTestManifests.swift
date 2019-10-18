import XCTest

extension FakeHTTPClientTests {
    static let __allTests = [
        ("testRequest_incrementsCallCount", testRequest_incrementsCallCount),
        ("testRequest_returnsNewFutureEachTime", testRequest_returnsNewFutureEachTime),
        ("testRequest_ordersStoredRequests", testRequest_ordersStoredRequests),
        ("testRequest_ordersStoredPromises", testRequest_ordersStoredPromises),
    ]
}

extension HTTPClientErrorTests {
    static let __allTests = [
        ("testParsingErrors", testParsingErrors),
    ]
}

extension NSURLSessionHTTPClientTests {
    static let __allTests = [
        ("testRequest_happyPath", testRequest_happyPath),
        ("testRequest_sadPath", testRequest_sadPath),
    ]
}

#if !os(macOS)
public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(FakeHTTPClientTests.__allTests),
        testCase(HTTPClientErrorTests.__allTests),
        testCase(NSURLSessionHTTPClientTests.__allTests),
    ]
}
#endif
