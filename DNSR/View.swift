//
//  ContentView.swift
//  DNSR
//
//  Created by Kota Nakano on 10/6/21.
//
import SwiftUI
struct View: SwiftUI.View {
	@EnvironmentObject var state: State
	var body: some SwiftUI.View {
		VStack {
			TextField("USER", text: state.user)
			SecureField("PASS", text: state.pass)
		}.padding()
	}
}
struct Preview: PreviewProvider {
	static let previews: some SwiftUI.View = View()
}
