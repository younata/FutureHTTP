import Foundation
#if os(Linux)
import FoundationNetworking
#endif

class FakeDataTask: URLSessionDataTask {
    var resumeCallCount: Int = 0
    override func resume() {
        resumeCallCount += 1
    }

    var cancelCallCount: Int = 0
    override func cancel() {
        cancelCallCount += 1
    }
}

class FakeURLSession: URLSession {
    var requests: [URLRequest] = []
    var dataTasks = [FakeDataTask]()
    var lastCompletionHandler: (Data?, URLResponse?, NSError?) -> (Void) = {_, _, _ in }

    #if !os(Linux)
    // declarations from extensions cannot be overriden yet on linux.
    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        requests.append(request)
        lastCompletionHandler = completionHandler
        let task = FakeDataTask()
        dataTasks.append(task)
        return task
    }
    #endif
}
