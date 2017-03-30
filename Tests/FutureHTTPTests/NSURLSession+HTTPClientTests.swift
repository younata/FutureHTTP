import Foundation
import Quick
import Nimble
import CBGPromise
import Result

@testable import FutureHTTP

class NSURLSessionHTTPClientTests: QuickSpec {
    override func spec() {
        var subject: FakeURLSession!

        beforeEach {
            subject = FakeURLSession()
        }

        describe("request()") {
            var future: Future<Result<HTTPResponse, HTTPClientError>>!

            let request = URLRequest(url: URL(string: "https://example.com")!)
            beforeEach {
                future = subject.request(request)
            }

            it("makes a single request") {
                expect(subject.requests.count) == 1
                expect(subject.requests.last) == request
            }

            it("actually starts the task") {
                expect(subject.dataTasks.last?.resumeCallCount) == 1
                expect(subject.dataTasks.last?.cancelCallCount) == 0
            }

            context("when the request succeeds") {
                let data = "Hello World".data(using: .utf8)
                let response = HTTPURLResponse(url: URL(string: "https://example.com")!, statusCode: 200, httpVersion: nil, headerFields: ["my": "header"])
                beforeEach {
                    subject.lastCompletionHandler(data, response, nil)
                }

                it("resolves the promise with an http response") {
                    expect(future.value).toNot(beNil())
                    let expectedRespnose = HTTPResponse(body: data!, status: .ok, mimeType: "", headers: ["my": "header"])
                    expect(future.value?.value).to(equal(expectedRespnose))
                }
            }

            context("when the request errors out") {
                beforeEach {
                    subject.lastCompletionHandler(nil, nil, NSError(domain: NSURLErrorDomain, code: NSURLErrorBadURL, userInfo: nil))
                }

                it("resolves the promise with an error depending on the result") {
                    expect(future.value).toNot(beNil())
                    expect(future.value?.error).to(equal(HTTPClientError.url(.bad)))
                }
            }
        }
    }
}
