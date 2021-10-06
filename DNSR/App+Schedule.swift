//
//  App+Schedule.swift
//  DNSR
//
//  Created by Kota Nakano on 10/6/21.
//
import BackgroundTasks
extension App {
	func setup() {
		let result = Bundle.main.bundleIdentifier.map {
			BGTaskScheduler.shared.register(forTaskWithIdentifier: $0, using: .global(qos: .background)) {
				switch $0 {
					case let task as BGProcessingTask:
						defer {
							schedule()
						}
						request(host: state.getHost(), user: state.getUser(), pass: state.getPass()).sink(receiveCompletion: {
							switch $0 {
								case.finished:
									task.setTaskCompleted(success: true)
								case.failure(let error):
									print(error)
									break
							}
							
						}, receiveValue: {
							state.set(status: "LAST UPDATE: \(Date()), \($0)")
						}).store(in: &type(of: self).cancel)
					default:
						break
				}
			}
		}
		assert(result == true)
	}
	func schedule() {
		Bundle.main.bundleIdentifier.map(BGProcessingTaskRequest.init).map {
			$0.requiresExternalPower = true
			$0.requiresNetworkConnectivity = true
			do {
				try BGTaskScheduler.shared.submit($0)
			} catch {
				
			}
		}
	}
}
