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
		let session: URLSession = .shared
		let resolve = URL(string: "https://domains.google.com/checkip").publisher.flatMap(session.dataTaskPublisher).flatMap {(data, response) -> Optional<String>.Publisher in
			switch response {
				case let response as HTTPURLResponse where (200..<300).contains(response.statusCode):
					return String(data: data, encoding: .utf8).publisher
				default:
					return Optional<String>.none.publisher
			}
			}.eraseToAnyPublisher()
		let query = resolve.flatMap { address -> Optional<URL>.Publisher in
			var components = URLComponents()
			components.scheme = "https"
			components.host = "domains.google.com"
			components.path = "/nic/update"
			components.user = user
			components.password = pass
			components.queryItems = [
				URLQueryItem(name: "hostname", value: "proxy.xsgn.art"),
				URLQueryItem(name: "myip", value: address),
			]
			return components.url.publisher
		}
		return query.flatMap(session.dataTaskPublisher).flatMap {(data, response) -> Optional<String>.Publisher in
			switch response {
				case let response as HTTPURLResponse where (200..<300).contains(response.statusCode):
					return String(data: data, encoding: .utf8).publisher
				default:
					return Optional<String>.none.publisher
			}
		}.eraseToAnyPublisher()
	}
}
