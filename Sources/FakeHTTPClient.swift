import Foundation
import CBGPromise
import Result

public class FakeHTTPClient: HTTPClient {
    private(set) var requestCallCount = 0
    private(set) var requests: [URLRequest] = []
    private(set) var requestPromises: [Promise<Result<HTTPResponse, HTTPClientError>>] = []

    public func request(_ request: URLRequest) -> Future<Result<HTTPResponse, HTTPClientError>> {
        requestCallCount += 1
        requests.append(request)
        let promise = Promise<Result<HTTPResponse, HTTPClientError>>()
        requestPromises.append(promise)
        return promise.future
    }
}
