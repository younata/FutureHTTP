import Foundation
#if os(Linux)
import FoundationNetworking
#endif
import XCTest
import CBGPromise

@testable import FutureHTTP

class NSURLSessionHTTPClientTests: XCTestCase {
    private let request = URLRequest(url: URL(string: "https://example.com")!)
    private var subject: FakeURLSession!
    private var future: Future<Result<HTTPResponse, HTTPClientError>>!

    override func setUp() {
        super.setUp()
        #if !os(Linux)
        self.subject = FakeURLSession()
        #else
        self.subject = FakeURLSession(configuration: .default)
        #endif
        self.future = self.subject.request(self.request)
    }

    func testRequest_happyPath() {
        self.assertSingleRequest()
        self.assertStartsRequest()

        let data = "Hello World".data(using: .utf8)
        let response = HTTPURLResponse(
            url: URL(string: "https://example.com")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: ["my": "header"]
        )
        self.subject.lastCompletionHandler(data, response, nil)

        XCTAssertNotNil(self.future.value, "Expected future to be resolved")
        XCTAssertNil(self.future.value?.error, "Expected future to be resolved successfully")
        XCTAssertEqual(
            self.future.value?.value,
            HTTPResponse(body: data!, status: .ok, mimeType: "", headers: ["my": "header"])
        )
    }

    func testRequest_sadPath() {
        self.assertSingleRequest()
        self.assertStartsRequest()

        self.subject.lastCompletionHandler(nil, nil, NSError(domain: NSURLErrorDomain, code: NSURLErrorBadURL, userInfo: nil))

        XCTAssertNotNil(self.future.value, "Expected future to be resolved")
        XCTAssertNil(self.future.value?.value, "Expected future to have resolved with an error")
        XCTAssertEqual(
            self.future.value?.error,
            HTTPClientError.url(.bad)
        )
    }

    private func assertSingleRequest() {
        XCTAssertEqual(self.subject.requests.count, 1)
        XCTAssertEqual(self.subject.requests.last, request)
    }

    private func assertStartsRequest() {
        XCTAssertEqual(self.subject.dataTasks.last?.resumeCallCount, 1)
        XCTAssertEqual(self.subject.dataTasks.last?.cancelCallCount, 0)
    }
}

extension Result {
    var value: Success? {
        switch self {
        case .success(let value): return value
        case .failure: return nil
        }
    }

    var error: Failure? {
        switch self {
        case .failure(let error): return error
        case .success: return nil
        }
    }
}
