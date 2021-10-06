//
//  State.swift
//  DNSR
//
//  Created by Kota Nakano on 10/6/21.
//
import SwiftUI
typealias State = UserDefaults
extension State {
	func getUser() -> String {
		string(forKey: "user") ?? ""
	}
	func set(user: String) {
		set(user, forKey: "user")
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
	}
	var pass: Binding<String> {
		.init(get: getPass, set: set(pass:))
	}
}
extension State: ObservableObject {
	
}
