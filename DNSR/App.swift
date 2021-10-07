//
//  DNSRApp.swift
//  DNSR
//
//  Created by Kota Nakano on 10/6/21.
//
import SwiftUI
@main
struct App: SwiftUI.App {
	let state = State()
	let queue = DispatchQueue.global(qos: .background)
	let view: some SwiftUI.View = View()
	var body: some Scene {
		WindowGroup {
			view.environmentObject(state)
		}
	}
	init() {
		state.set(status: "")
		setup()
		entry()
	}
}
