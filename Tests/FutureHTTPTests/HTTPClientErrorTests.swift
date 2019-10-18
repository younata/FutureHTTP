import XCTest
import Foundation
#if os(Linux)
import FoundationNetworking
#endif

@testable import FutureHTTP

class HTTPClientErrorTests: XCTestCase {
    private func clientError(_ code: Int) -> HTTPClientError {
        return NSURLErrorToHTTPClientError(error: NSError(domain: NSURLErrorDomain, code: code, userInfo: nil))
    }

    func testParsingErrors() {
        XCTAssertEqual(
            NSURLErrorToHTTPClientError(error: NSError(domain: "dunno", code: 0, userInfo: nil)),
            HTTPClientError.unknown("Received non-NSURLErrorDomain error \(NSError(domain: "dunno", code: 0, userInfo: nil))")
        )

        XCTAssertEqual(clientError(NSURLErrorUnknown), HTTPClientError.unknown("Received unknown error: \(NSError(domain: NSURLErrorDomain, code: NSURLErrorUnknown, userInfo: nil))"))
        XCTAssertEqual(clientError(NSURLErrorBadURL), HTTPClientError.url(.bad))
        XCTAssertEqual(clientError(NSURLErrorUnsupportedURL), HTTPClientError.url(.unsupported))
        XCTAssertEqual(clientError(NSURLErrorCancelled), HTTPClientError.network(.cancelled))
        XCTAssertEqual(clientError(NSURLErrorTimedOut), HTTPClientError.network(.timedOut))
        XCTAssertEqual(clientError(NSURLErrorCannotFindHost), HTTPClientError.network(.cannotFindHost))
        XCTAssertEqual(clientError(NSURLErrorCannotConnectToHost), HTTPClientError.network(.cannotConnectTohost))
        XCTAssertEqual(clientError(NSURLErrorNetworkConnectionLost), HTTPClientError.network(.connectionLost))
        XCTAssertEqual(clientError(NSURLErrorDNSLookupFailed), HTTPClientError.network(.dnsFailed))
        XCTAssertEqual(clientError(NSURLErrorNotConnectedToInternet), HTTPClientError.network(.notConnectedToInternet))
        XCTAssertEqual(clientError(NSURLErrorCannotLoadFromNetwork), HTTPClientError.network(.connectionLost))
        XCTAssertEqual(clientError(NSURLErrorHTTPTooManyRedirects), HTTPClientError.http(.tooManyRedirects))
        XCTAssertEqual(clientError(NSURLErrorResourceUnavailable), HTTPClientError.http(.resourceUnavailable))
        XCTAssertEqual(clientError(NSURLErrorRedirectToNonExistentLocation), HTTPClientError.http(.redirectToNonexistentLocation))
        XCTAssertEqual(clientError(NSURLErrorBadServerResponse), HTTPClientError.http(.badServerResponse))
        XCTAssertEqual(clientError(NSURLErrorUserCancelledAuthentication), HTTPClientError.http(.userCancelledAuthentication))
        XCTAssertEqual(clientError(NSURLErrorUserAuthenticationRequired), HTTPClientError.http(.userAuthenticationRequired))
        XCTAssertEqual(clientError(NSURLErrorZeroByteResource), HTTPClientError.http(.zeroByteResource))
        XCTAssertEqual(clientError(NSURLErrorCannotDecodeRawData), HTTPClientError.http(.cannotDecodeRawData))
        XCTAssertEqual(clientError(NSURLErrorCannotDecodeContentData), HTTPClientError.http(.cannotDecodeContentData))
        XCTAssertEqual(clientError(NSURLErrorCannotParseResponse), HTTPClientError.http(.cannotParseResponse))
        XCTAssertEqual(clientError(NSURLErrorNoPermissionsToReadFile), HTTPClientError.http(.resourceUnavailable))
        XCTAssertEqual(clientError(NSURLErrorSecureConnectionFailed), HTTPClientError.security(.secureConnectionFailed))
        XCTAssertEqual(clientError(NSURLErrorServerCertificateHasBadDate), HTTPClientError.security(.serverCertificateHasBadDate))
        XCTAssertEqual(clientError(NSURLErrorServerCertificateUntrusted), HTTPClientError.security(.serverCertificateUntrusted))
        XCTAssertEqual(clientError(NSURLErrorServerCertificateHasUnknownRoot), HTTPClientError.security(.serverCertificateHasUnknownRoot))
        XCTAssertEqual(clientError(NSURLErrorServerCertificateNotYetValid), HTTPClientError.security(.serverCertificateNotYetValid))
        XCTAssertEqual(clientError(NSURLErrorClientCertificateRejected), HTTPClientError.security(.clientCertificateRejected))
        XCTAssertEqual(clientError(NSURLErrorClientCertificateRequired), HTTPClientError.security(.clientCertificateRequired))
    }
}

