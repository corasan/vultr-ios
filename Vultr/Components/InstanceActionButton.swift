//
//  InstanceActionButton.swift
//  Vultr
//
//  Created by Henry Paulino on 5/24/21.
//

import SwiftUI

struct InstanceActionButton: View {
	var action: () -> Void
	var label: String
	var icon: String
	
	var body: some View {
		Button(action: action) {
			Text(label)
				.foregroundColor(Color("vultr_blue"))
				.font(.system(size: 22))
				.fontWeight(.medium)
			Image(systemName: icon)
				.font(.system(size: 24, weight: .bold))
				.foregroundColor(Color("vultr_blue"))
		}
		.padding(.horizontal, 20)
	}
}

struct InstanceActionButton_Previews: PreviewProvider {
	
    static var previews: some View {
		InstanceActionButton(action: {}, label: "Button", icon: "play.fill")
    }
}
