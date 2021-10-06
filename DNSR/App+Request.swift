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
		func parse(data: Data, response: URLResponse) -> Optional<String>.Publisher {
			switch response {
				case let response as HTTPURLResponse where (200..<300).contains(response.statusCode):
					return String(data: data, encoding: .utf8).publisher
				default:
					return.init(.none)
			}
		}
		func compose(address: String) -> Optional<URL>.Publisher {
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
			return components.url.publisher
		}
		let session: URLSession = .shared
		return URL(string: "https://domains.google.com/checkip").publisher
			.flatMap(session.dataTaskPublisher)
			.flatMap(parse)
			.flatMap(compose)
			.flatMap(session.dataTaskPublisher)
			.flatMap(parse)
			.eraseToAnyPublisher()
	}
}
