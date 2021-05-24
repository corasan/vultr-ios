//
//  InstanceItem.swift
//  Vultr
//
//  Created by Henry Paulino on 5/23/21.
//

import SwiftUI

struct InstanceItem: View {
	var instance: Instance

	init(instance: Instance) {
		self.instance = instance
	}
	
	private func powerStatus(_ status: String) -> String {
		return status == "running" ? "play.circle" : "stop.circle"
	}
	
	private func isRunning(_ status: String) -> Bool {
		return status == "running"
	}

    var body: some View {
		VStack {
			HStack {
				VStack(alignment: .leading) {
					Text(self.instance.label)
						.fontWeight(.semibold)
						.padding(.bottom, 1)
					Text(self.instance.main_ip)
						.foregroundColor(.gray)
				}
				Spacer()
				VStack {
					Image(systemName: powerStatus(self.instance.power_status))
						.font(.largeTitle)
						.foregroundColor(isRunning(self.instance.power_status) ? .green : .gray)
				}
			}
			
		}
		.frame(maxWidth: .infinity, alignment: .leading)
		.padding(.vertical, 18)
		.padding(.horizontal)
		.background(Color("background_light"))
		.cornerRadius(6)
    }
}

struct InstanceItem_Previews: PreviewProvider {
	static var instance = Instance(id: "123abc", label: "Stocket Server", main_ip: "123.23.142.1", os: "Ubuntu", status: "active", power_status: "running")
    static var previews: some View {
		InstanceItem(instance: instance)
    }
}
