//
//  DNSRApp.swift
//  DNSR
//
//  Created by Kota Nakano on 10/6/21.
//
import SwiftUI
import BackgroundTasks
@main
struct App: SwiftUI.App {
	let state = State()
	let view: some SwiftUI.View = View()
	var body: some Scene {
		WindowGroup {
			view.environmentObject(state)
		}
	}
	init() {
		let scheduler: BGTaskScheduler = .shared
		let result = Bundle.main.bundleIdentifier.map {
			scheduler.register(forTaskWithIdentifier: $0, using: .none, launchHandler: `do`)
		}
		assert(result == true)
	}
}
extension App {
	func `do`(tasl: BGTask) {
		print("ok")
	}
}
