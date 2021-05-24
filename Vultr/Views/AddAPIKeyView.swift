//
//  AddAPIKeyView.swift
//  Vultr
//
//  Created by Henry Paulino on 5/23/21.
//

import SwiftUI

struct AddAPIKeyView: View {
	@State private var apiKey = ""
	@Environment(\.colorScheme) var colorScheme
	@EnvironmentObject var vultrAPI: VultrAPI

    var body: some View {
		VStack {
			Image(colorScheme == .dark ? "logo_white" : "logo_dark")
				.padding(.top, 40)
			Spacer()

			VStack(alignment: .center) {
				Text("First, let's add your API Key")
					.font(.title2)
					.fontWeight(.bold)
					.padding(.bottom, 30)
				TextField("API Key", text: $apiKey)
					.padding(.horizontal, 10)
					.padding(.vertical, 14)
					.background(Color("background_light"))
					.font(.title3)
					.cornerRadius(10)
			}

			Spacer()
			Spacer()

			HStack {
				Spacer()
				Button(action: { vultrAPI.setApiKey(self.apiKey) }) {
					HStack {
						Text("Continue")
							.font(.title2)
							.fontWeight(.semibold)
						Image(systemName: "arrow.forward")
							.font(.system(size: 24, weight: .bold))
					}
					.foregroundColor(.white)
					.padding(.vertical, 18)
					.padding(.horizontal, 32)
					.background(Color("vultr_blue"))
					.cornerRadius(10)
				}
			}
		}
		.padding(.horizontal, 18)
    }
}

struct AddAPIKeyView_Previews: PreviewProvider {
    static var previews: some View {
		AddAPIKeyView()
    }
}
