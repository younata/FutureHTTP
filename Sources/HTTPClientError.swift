public enum HTTPClientError: Error, Equatable {
    case unknown

    case url(URLError)

    case network(NetworkError)

    case http(HTTPError)

    case security(SecurityError)

    public static func ==(lhs: HTTPClientError, rhs: HTTPClientError) -> Bool {
        switch (lhs, rhs) {
        case (.unknown, .unknown):
            return true
        case (.url(let lhsURL), .url(let rhsURL)):
            return lhsURL == rhsURL
        case (.network(let lhsNetwork), .network(let rhsNetwork)):
            return lhsNetwork == rhsNetwork
        case (.http(let lhsHTTP), .http(let rhsHTTP)):
            return lhsHTTP == rhsHTTP
        case (.security(let lhsSec), .security(let rhsSec)):
            return lhsSec == rhsSec
        default:
            return false
        }
    }
}

public enum URLError: Error {
    case bad
    case unsupported
}

public enum NetworkError: Error {
    case cancelled
    case timedOut
    case cannotFindHost
    case cannotConnectTohost
    case connectionLost
    case dnsFailed
    case notConnectedToInternet
}

public enum HTTPError: Error {
    case tooManyRedirects
    case resourceUnavailable
    case redirectToNonexistentLocation
    case badServerResponse
    case userCancelledAuthentication
    case userAuthenticationRequired
    case zeroByteResource
    case cannotDecodeRawData
    case cannotDecodeContentData
    case cannotParseResponse
}

public enum SecurityError: Error {
    case appTransportSecurity

    case secureConnectionFailed
    case serverCertificateHasBadDate
    case serverCertificateUntrusted
    case serverCertificateHasUnknownRoot
    case serverCertificateNotYetValid
    case clientCertificateRejected
    case clientCertificateRequired
    case cannotLoadFromNetwork
}
