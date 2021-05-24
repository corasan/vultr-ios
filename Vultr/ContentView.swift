//
//  ContentView.swift
//  Vultr
//
//  Created by Henry Paulino on 5/23/21.
//

import SwiftUI

struct ContentView: View {
	@ObservedObject var vultrAPI = VultrAPI()

    var body: some View {
		Group {
			if (vultrAPI.apiKey.isEmpty) {
				AddAPIKeyView()
					.environmentObject(vultrAPI)
			} else {
				InstancesView()
					.environmentObject(vultrAPI)
			}
		}
		.ignoresSafeArea(edges: .top)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
		ContentView()
			.preferredColorScheme(.dark)
    }
}
