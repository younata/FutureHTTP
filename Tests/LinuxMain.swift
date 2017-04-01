import XCTest
import Quick

@testable import FutureHTTPTests

Quick.QCKMain([
        FakeHTTPClientTests.self,
        HTTPClientErrorTests.self
    ],
    testCases: [
        testCase(FakeHTTPClientTests.allTests),
        testCase(HTTPClientErrorTests.allTests)
    ]
)
