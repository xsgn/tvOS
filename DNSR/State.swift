//
//  State.swift
//  DNSR
//
//  Created by Kota Nakano on 10/6/21.
//
import SwiftUI
typealias State = UserDefaults
extension State {
	func getHost() -> String {
		string(forKey: "host") ?? ""
	}
	func set(host: String) {
		setValue(host, forKey: "host")
		synchronize()
	}
	var host: Binding<String> {
		.init(get: getHost, set: set(host:))
	}
}
extension State {
	func getUser() -> String {
		string(forKey: "user") ?? ""
	}
	func set(user: String) {
		set(user, forKey: "user")
		synchronize()
	}
	var user: Binding<String> {
		.init(get: getUser, set: set(user:))
	}
}
extension State {
	func getPass() -> String {
		string(forKey: "pass") ?? ""
	}
	func set(pass: String) {
		set(pass, forKey: "pass")
		synchronize()
	}
	var pass: Binding<String> {
		.init(get: getPass, set: set(pass:))
	}
}
extension State {
	func getStatus() -> String {
		string(forKey: "status") ?? ""
	}
	func set(status: String) {
		setValue(status, forKey: "status")
		synchronize()
	}
	var status: Binding<String> {
		.init(get: getStatus, set: set(status:))
	}
}
extension State: ObservableObject {
	
}
