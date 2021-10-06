//
//  DNSRApp.swift
//  DNSR
//
//  Created by Kota Nakano on 10/6/21.
//
import SwiftUI
import BackgroundTasks
import Combine
@main
struct App: SwiftUI.App {
	let state = State()
	let queue = DispatchQueue.global(qos: .background)
	let view: some SwiftUI.View = View()
	var sink = Set<AnyCancellable>()
	var body: some Scene {
		WindowGroup {
			view.environmentObject(state)
		}
	}
	init() {
		let state = state
		request(host: state.getHost(),
				user: state.getUser(),
				pass: state.getPass()).sink(receiveCompletion: {
					switch $0 {
						case.finished:
							break
						case.failure(let error):
							break
					}
				}, receiveValue: {
					state.set(status: $0)
				}).store(in: &sink)
	}
}
