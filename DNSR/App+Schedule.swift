//
//  App+Schedule.swift
//  DNSR
//
//  Created by Kota Nakano on 10/6/21.
//
import BackgroundTasks
extension App {
	func setup(task: BGTask) {
		
	}
	func entry() {
		let result = Bundle.main.bundleIdentifier.map {
			BGTaskScheduler.shared.register(forTaskWithIdentifier: $0, using: .global(qos: .background), launchHandler: setup)
		}
		assert(result == true)
	}
}
