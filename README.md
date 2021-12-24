# FutureHTTP

The testable network library

## Archived

This library is no longer maintained. You should use `URLSession` with Combine, i.e.:

```swift
protocol HTTPClient {
    func dataTask(request: URLRequest) -> AnyPublisher<(data: Data, response: URLResponse), URLError>
}

extension URLSession: HTTPClient {
    func dataTask(request: URLRequest) -> AnyPublisher<(data: Data, response: URLResponse), URLError> {
        return dataTaskPublisher(for: request).eraseToAnyPublisher()
    }
}

// In code:

let client: HTTPClient = URLSession.shared
client.dataTask(request: URLRequest(url: myUrl)).sink { completion in ... } receiveValue: { (data: Data, response: URLResponse) in ... }
```
