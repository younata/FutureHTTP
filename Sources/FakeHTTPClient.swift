import Foundation
import CBGPromise
import Result

public class FakeHTTPClient: HTTPClient {
    public private(set) var requestCallCount = 0
    public private(set) var requests: [URLRequest] = []
    public private(set) var requestPromises: [Promise<Result<HTTPResponse, HTTPClientError>>] = []

    public init() {}

    public func request(_ request: URLRequest) -> Future<Result<HTTPResponse, HTTPClientError>> {
        requestCallCount += 1
        requests.append(request)
        let promise = Promise<Result<HTTPResponse, HTTPClientError>>()
        requestPromises.append(promise)
        return promise.future
    }
}
