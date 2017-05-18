import Foundation
import CBGPromise
import Result

public protocol HTTPClient {
    func request(_ request: URLRequest) -> Future<Result<HTTPResponse, HTTPClientError>>
}

extension URLSession: HTTPClient {
    public func request(_ request: URLRequest) -> Future<Result<HTTPResponse, HTTPClientError>> {
        let promise = Promise<Result<HTTPResponse, HTTPClientError>>()
            self.dataTask(with: request) { data, response, error in
                #if os(Linux)
                if let error = error as? NSError {
                    promise.resolve(.failure(NSURLErrorToHTTPClientError(error: error)))
                    return
                }
                #else
                    if let error = error {
                        promise.resolve(.failure(NSURLErrorToHTTPClientError(error: error as NSError)))
                        return
                    }
                #endif
                self.handle(data: data, response: response, promise: promise)
        }.resume()
        return promise.future
    }

    private func handle(data: Data?, response: URLResponse?, promise: Promise<Result<HTTPResponse, HTTPClientError>>) {
        guard let urlResponse = response as? HTTPURLResponse,
            let data = data else {
                promise.resolve(.failure(.unknown))
                return
        }
        let status = HTTPStatus(rawValue: urlResponse.statusCode)

        let httpResponse = HTTPResponse(
            body: data,
            status: status,
            mimeType: urlResponse.mimeType ?? "",
            headers: (urlResponse.allHeaderFields as? [String: String]) ?? [:]
        )
        promise.resolve(.success(httpResponse))
    }
}

func NSURLErrorToHTTPClientError(error: NSError) -> HTTPClientError {
    guard error.domain == NSURLErrorDomain else {
        return .unknown
    }
    let failure: HTTPClientError
    switch error.code {
    case NSURLErrorUnknown:
        failure = .unknown

    case NSURLErrorBadURL:
        failure = .url(.bad)
    case NSURLErrorUnsupportedURL:
        failure = .url(.unsupported)

    case NSURLErrorCancelled:
        failure = .network(.cancelled)
    case NSURLErrorTimedOut:
        failure = .network(.timedOut)
    case NSURLErrorCannotFindHost:
        failure = .network(.cannotFindHost)
    case NSURLErrorCannotConnectToHost:
        failure = .network(.cannotConnectTohost)
    case NSURLErrorNetworkConnectionLost:
        failure = .network(.connectionLost)
    case NSURLErrorDNSLookupFailed:
        failure = .network(.dnsFailed)
    case NSURLErrorNotConnectedToInternet:
        failure = .network(.notConnectedToInternet)
    case NSURLErrorCannotLoadFromNetwork:
        failure = .network(.connectionLost)

    case NSURLErrorHTTPTooManyRedirects:
        failure = .http(.tooManyRedirects)
    case NSURLErrorResourceUnavailable:
        failure = .http(.resourceUnavailable)
    case NSURLErrorRedirectToNonExistentLocation:
        failure = .http(.redirectToNonexistentLocation)
    case NSURLErrorBadServerResponse:
        failure = .http(.badServerResponse)
    case NSURLErrorUserCancelledAuthentication:
        failure = .http(.userCancelledAuthentication)
    case NSURLErrorUserAuthenticationRequired:
        failure = .http(.userAuthenticationRequired)
    case NSURLErrorZeroByteResource:
        failure = .http(.zeroByteResource)
    case NSURLErrorCannotDecodeRawData:
        failure = .http(.cannotDecodeRawData)
    case NSURLErrorCannotDecodeContentData:
        failure = .http(.cannotDecodeContentData)
    case NSURLErrorCannotParseResponse:
        failure = .http(.cannotParseResponse)
    case NSURLErrorNoPermissionsToReadFile:
        failure = .http(.resourceUnavailable)

    case NSURLErrorSecureConnectionFailed:
        failure = .security(.secureConnectionFailed)
    case NSURLErrorServerCertificateHasBadDate:
        failure = .security(.serverCertificateHasBadDate)
    case NSURLErrorServerCertificateUntrusted:
        failure = .security(.serverCertificateUntrusted)
    case NSURLErrorServerCertificateHasUnknownRoot:
        failure = .security(.serverCertificateHasUnknownRoot)
    case NSURLErrorServerCertificateNotYetValid:
        failure = .security(.serverCertificateNotYetValid)
    case NSURLErrorClientCertificateRejected:
        failure = .security(.clientCertificateRejected)
    case NSURLErrorClientCertificateRequired:
        failure = .security(.clientCertificateRequired)

    default:
        if #available(OSX 10.11, *), error.code == NSURLErrorAppTransportSecurityRequiresSecureConnection {
            failure = .security(.appTransportSecurity)
        } else {
            failure = .unknown
        }
    }
    return failure
}
