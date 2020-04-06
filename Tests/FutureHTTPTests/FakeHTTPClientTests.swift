import Foundation
#if os(Linux)
import FoundationNetworking
#endif
import XCTest
import CBGPromise

@testable import FutureHTTP

class FakeHTTPClientTests: XCTestCase {
    private let request = URLRequest(url: URL(string: "https://example.com")!)
    func testRequest_incrementsCallCount() {
        let subject = FakeHTTPClient()

        _ = subject.request(self.request)
        XCTAssertEqual(subject.requestCallCount, 1)

        _ = subject.request(self.request)
        XCTAssertEqual(subject.requestCallCount, 2)
    }

    func testRequest_returnsNewFutureEachTime() {
        let subject = FakeHTTPClient()

        let future1 = subject.request(self.request)
        let future2 = subject.request(self.request)
        XCTAssertTrue(future1 !== future2)
    }

    func testRequest_ordersStoredRequests() {
        let subject = FakeHTTPClient()

        let request1 = URLRequest(url: URL(string: "https://example.com/1")!)
        let request2 = URLRequest(url: URL(string: "https://example.com/2")!)

        _ = subject.request(request1)
        _ = subject.request(request2)
        XCTAssertEqual(subject.requests.count, 2)
        XCTAssertEqual(subject.requests[0], request1)
        XCTAssertEqual(subject.requests[1], request2)
    }

    func testRequest_ordersStoredPromises() {
        let subject = FakeHTTPClient()

        let future1 = subject.request(self.request)
        let future2 = subject.request(self.request)

        XCTAssertEqual(subject.requestPromises.count, 2)
        XCTAssertTrue(subject.requestPromises[0].future === future1, "First promise's future did not equal first returned future")
        XCTAssertTrue(subject.requestPromises[1].future === future2, "Second promise's future did not equal second returned future")
    }
}
