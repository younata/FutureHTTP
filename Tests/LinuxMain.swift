import XCTest

@testable import FutureHTTPTests

var tests = [XCTestCaseEntry]()
tests += FutureHTTPTests.__allTests()

XCTMain(tests)
