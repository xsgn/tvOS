//
//  Core.swift
//  DNSR
//
//  Created by Kota Nakano on 10/6/21.
//
import Foundation
import Combine
extension App {
	func request(host: String, user: String, pass: String) -> AnyPublisher<String, URLSession.DataTaskPublisher.Failure> {
		func parse(data: Data, response urlresponse: URLResponse) -> AnyPublisher<Data, URLError> {
			switch urlresponse {
				case let response as HTTPURLResponse where (200..<300).contains(response.statusCode):
					return Just(data).setFailureType(to: URLError.self).eraseToAnyPublisher()
				case let response as HTTPURLResponse:
					return Fail<Data, URLError>(error: .init(.init(rawValue: response.statusCode))).eraseToAnyPublisher()
				default:
					return Fail<Data, URLError>(error: .init(URLError.unknown)).eraseToAnyPublisher()
			}
		}
		func encode(data: Data) -> Optional<String> {
			String(data: data, encoding: .utf8)
		}
		func compose(address: String) -> Optional<URL> {
			var components = URLComponents()
			components.scheme = "https"
			components.host = "domains.google.com"
			components.path = "/nic/update"
			components.user = user
			components.password = pass
			components.queryItems = [
				URLQueryItem(name: "hostname", value: host),
				URLQueryItem(name: "myip", value: address),
			]
			return components.url
		}
		let session: URLSession = .shared
		return Just("https://domains.google.com/checkip")
			.compactMap(URL.init)
			.flatMap(session.dataTaskPublisher)
			.flatMap(parse)
			.compactMap(encode)
			.compactMap(compose)
			.flatMap(session.dataTaskPublisher)
			.flatMap(parse)
			.compactMap(encode)
			.eraseToAnyPublisher()
	}
}
extension App {
	static var cancel: Set<AnyCancellable> = .init()
}
