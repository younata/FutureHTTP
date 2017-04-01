import Foundation
import Quick
import Nimble
import CBGPromise
import Result

@testable import FutureHTTP

class FakeHTTPClientTests: QuickSpec {
    override func spec() {
        var subject: FakeHTTPClient!

        beforeEach {
            subject = FakeHTTPClient()
        }

        describe("request()") {
            it("increments the call count each time request is called") {
                let request = URLRequest(url: URL(string: "https://example.com")!)

                _ = subject.request(request)
                expect(subject.requestCallCount).to(equal(1))
                _ = subject.request(request)
                expect(subject.requestCallCount).to(equal(2))
            }

            it("returns a new future each time request is called") {
                let request = URLRequest(url: URL(string: "https://example.com")!)

                let future1 = subject.request(request)
                let future2 = subject.request(request)
                expect(future1).toNot(beIdenticalTo(future2))
            }

            it("allows the requests to be obtained in the order they're made") {
                let request1 = URLRequest(url: URL(string: "https://example.com/1")!)
                let request2 = URLRequest(url: URL(string: "https://example.com/2")!)

                _ = subject.request(request1)
                _ = subject.request(request2)
                expect(subject.requests).to(haveCount(2))
                expect(subject.requests[0]).to(equal(request1))
                expect(subject.requests[1]).to(equal(request2))
            }

            it("allows the promises to be obtained in the order they're made") {
                let request = URLRequest(url: URL(string: "https://example.com")!)

                let future1 = subject.request(request)
                let future2 = subject.request(request)

                expect(subject.requestPromises).to(haveCount(2))
                expect(subject.requestPromises[0].future).to(beIdenticalTo(future1))
                expect(subject.requestPromises[1].future).to(beIdenticalTo(future2))
            }
        }
    }
}
