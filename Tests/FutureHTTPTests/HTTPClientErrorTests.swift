import Quick
import Nimble
import Foundation

@testable import FutureHTTP

class HTTPClientErrorTests: QuickSpec {
    override func spec() {
        describe("NSURLErrorToHTTPClientError(error:)") {
            func clientError(_ code: Int) -> HTTPClientError {
                return NSURLErrorToHTTPClientError(error: NSError(domain: NSURLErrorDomain, code: code, userInfo: nil))
            }
            it("domain is not NSURLErrorDomain") {
                let error = NSError(domain: "dunno", code: 0, userInfo: nil)
                expect(NSURLErrorToHTTPClientError(error: error)) == HTTPClientError.unknown("Received non-NSURLErrorDomain error \(error)")
            }

            it("NSURLErrorUnknown") {
                expect(clientError(NSURLErrorUnknown)) == HTTPClientError.unknown("Received unknown error: \(NSError(domain: NSURLErrorDomain, code: NSURLErrorUnknown, userInfo: nil))")
            }

            it("NSURLErrorBadURL") {
                expect(clientError(NSURLErrorBadURL)) == HTTPClientError.url(.bad)
            }
            it("NSURLErrorUnsupportedURL") {
                expect(clientError(NSURLErrorUnsupportedURL)) == HTTPClientError.url(.unsupported)
            }

            it("NSURLErrorCancelled") {
                expect(clientError(NSURLErrorCancelled)) == HTTPClientError.network(.cancelled)
            }
            it("NSURLErrorTimedOut") {
                expect(clientError(NSURLErrorTimedOut)) == HTTPClientError.network(.timedOut)
            }
            it("NSURLErrorCannotFindHost") {
                expect(clientError(NSURLErrorCannotFindHost)) == HTTPClientError.network(.cannotFindHost)
            }
            it("NSURLErrorCannotConnectToHost") {
                expect(clientError(NSURLErrorCannotConnectToHost)) == HTTPClientError.network(.cannotConnectTohost)
            }
            it("NSURLErrorNetworkConnectionLost") {
                expect(clientError(NSURLErrorNetworkConnectionLost)) == HTTPClientError.network(.connectionLost)
            }
            it("NSURLErrorDNSLookupFailed") {
                expect(clientError(NSURLErrorDNSLookupFailed)) == HTTPClientError.network(.dnsFailed)
            }
            it("NSURLErrorNotConnectedToInternet") {
                expect(clientError(NSURLErrorNotConnectedToInternet)) == HTTPClientError.network(.notConnectedToInternet)
            }
            it("NSURLErrorCannotLoadFromNetwork") {
                expect(clientError(NSURLErrorCannotLoadFromNetwork)) == HTTPClientError.network(.connectionLost)
            }

            it("NSURLErrorHTTPTooManyRedirects") {
                expect(clientError(NSURLErrorHTTPTooManyRedirects)) == HTTPClientError.http(.tooManyRedirects)
            }
            it("NSURLErrorResourceUnavailable") {
                expect(clientError(NSURLErrorResourceUnavailable)) == HTTPClientError.http(.resourceUnavailable)
            }
            it("NSURLErrorRedirectToNonExistentLocation") {
                expect(clientError(NSURLErrorRedirectToNonExistentLocation)) == HTTPClientError.http(.redirectToNonexistentLocation)
            }
            it("NSURLErrorBadServerResponse") {
                expect(clientError(NSURLErrorBadServerResponse)) == HTTPClientError.http(.badServerResponse)
            }
            it("NSURLErrorUserCancelledAuthentication") {
                expect(clientError(NSURLErrorUserCancelledAuthentication)) == HTTPClientError.http(.userCancelledAuthentication)
            }
            it("NSURLErrorUserAuthenticationRequired") {
                expect(clientError(NSURLErrorUserAuthenticationRequired)) == HTTPClientError.http(.userAuthenticationRequired)
            }
            it("NSURLErrorZeroByteResource") {
                expect(clientError(NSURLErrorZeroByteResource)) == HTTPClientError.http(.zeroByteResource)
            }
            it("NSURLErrorCannotDecodeRawData") {
                expect(clientError(NSURLErrorCannotDecodeRawData)) == HTTPClientError.http(.cannotDecodeRawData)
            }
            it("NSURLErrorCannotDecodeContentData") {
                expect(clientError(NSURLErrorCannotDecodeContentData)) == HTTPClientError.http(.cannotDecodeContentData)
            }
            it("NSURLErrorCannotParseResponse") {
                expect(clientError(NSURLErrorCannotParseResponse)) == HTTPClientError.http(.cannotParseResponse)
            }
            it("NSURLErrorNoPermissionsToReadFile") {
                expect(clientError(NSURLErrorNoPermissionsToReadFile)) == HTTPClientError.http(.resourceUnavailable)
            }

            it("NSURLErrorSecureConnectionFailed") {
                expect(clientError(NSURLErrorSecureConnectionFailed)) == HTTPClientError.security(.secureConnectionFailed)
            }
            it("NSURLErrorServerCertificateHasBadDate") {
                expect(clientError(NSURLErrorServerCertificateHasBadDate)) == HTTPClientError.security(.serverCertificateHasBadDate)
            }
            it("NSURLErrorServerCertificateUntrusted") {
                expect(clientError(NSURLErrorServerCertificateUntrusted)) == HTTPClientError.security(.serverCertificateUntrusted)
            }
            it("NSURLErrorServerCertificateHasUnknownRoot") {
                expect(clientError(NSURLErrorServerCertificateHasUnknownRoot)) == HTTPClientError.security(.serverCertificateHasUnknownRoot)
            }
            it("NSURLErrorServerCertificateNotYetValid") {
                expect(clientError(NSURLErrorServerCertificateNotYetValid)) == HTTPClientError.security(.serverCertificateNotYetValid)
            }
            it("NSURLErrorClientCertificateRejected") {
                expect(clientError(NSURLErrorClientCertificateRejected)) == HTTPClientError.security(.clientCertificateRejected)
            }
            it("NSURLErrorClientCertificateRequired") {
                expect(clientError(NSURLErrorClientCertificateRequired)) == HTTPClientError.security(.clientCertificateRequired)
            }
        }
    }
}

