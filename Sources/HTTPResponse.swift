import Foundation

public struct HTTPResponse: Equatable {
    public var body: Data
    public var status: HTTPStatus?
    public var mimeType: String
    public var headers: [String: String]

    public init(body: Data, status: HTTPStatus?, mimeType: String, headers: [String: String]) {
        self.body = body
        self.status = status
        self.mimeType = mimeType
        self.headers = headers
    }

    public static func ==(lhs: HTTPResponse, rhs: HTTPResponse) -> Bool {
        return lhs.status == rhs.status &&
            lhs.mimeType == rhs.mimeType &&
            lhs.headers == rhs.headers &&
            lhs.body == rhs.body
    }
}

public enum HTTPStatus: Int {
    case `continue` = 100
    case switchingProtocols = 101
    case processing = 102

    case genericInformation = 199


    case ok = 200
    case created = 201
    case accepted = 202
    case nonAuthoritativeInformation = 203
    case noContent = 204
    case resetContent = 205
    case partialContent = 206
    case multiStatus = 207

    case genericSuccess = 299


    case multipleChoices = 300
    case movedPermanently = 301
    case movedTemporarily = 302
    case seeOther = 303
    case notModified = 304
    case useProxy = 305
    case temporaryRedirect = 307

    case genericRedirection = 399


    case badRequest = 400
    case unauthorized = 401
    case paymentRequired = 402
    case forbidden = 403
    case notFound = 404
    case methodNotAllowed = 405
    case notAcceptable = 406
    case proxyAuthenticationRequired = 407
    case requestTimeout = 408
    case conflict = 409
    case gone = 410
    case lengthRequired = 411
    case preconditionFailed = 412
    case requestTooLong = 413
    case requestURITooLong = 414
    case unsupportedMediaType = 415
    case requestedRangeNotSatisfiable = 416
    case expectationFailed = 417
    case insufficientSpaceOnResource = 419
    case methodFailure = 420
    case unprocessableEntity = 422
    case failedDependency  = 424
    case preconditionRequired = 428
    case tooManyRequests = 429
    case requestHeaderFieldsTooLarge = 431

    case genericClientError = 499


    case internalServerError = 500
    case notImplemented = 501
    case badGateway = 502
    case serviceUnavailable = 503
    case gatewayTimeout = 504
    case httpVersionNotSupported = 505
    case insufficientStorage = 507
    case networkAuthenticationRequired = 511

    case genericServerError = 599
}
