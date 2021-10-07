//
//  App+Schedule.swift
//  DNSR
//
//  Created by Kota Nakano on 10/6/21.
//
import BackgroundTasks
extension App {
	func setup(identifier: String) -> Bool {
		BGTaskScheduler.shared.register(forTaskWithIdentifier: identifier, using: .global(qos: .background)) {
			switch $0 {
				case let task as BGProcessingTask:
					defer {
						entry()
					}
					request(host: state.getHost(), user: state.getUser(), pass: state.getPass()).sink(receiveCompletion: {
						switch $0 {
							case.finished:
								task.setTaskCompleted(success: true)
							case.failure(let error):
								`catch`(error: error)
						}
						
					}, receiveValue: {
						state.set(status: "UPDATED: \(Date()), \($0)")
					}).store(in: &type(of: self).cancel)
				default:
					break
			}
		}
	}
	func setup() {
		switch Bundle.main.bundleIdentifier.map(setup) {
			case.some(true):
				break
			case.some(false),.none:
				break
		}
	}
	func entry() {
		Bundle.main.bundleIdentifier.map(BGProcessingTaskRequest.init).map {
			$0.requiresExternalPower = true
			$0.requiresNetworkConnectivity = true
			$0.earliestBeginDate = .init(timeIntervalSinceNow: 60 * 60)
			do {
				try BGTaskScheduler.shared.submit($0)
			} catch {
				`catch`(error: error)
			}
		}
	}
}
extension App {
	func `catch`(error: Swift.Error) {
		state.set(status: "FAILURE: \(Date()), \(error)")
	}
}
