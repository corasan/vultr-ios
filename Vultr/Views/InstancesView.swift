//
//  InstancesView.swift
//  Vultr
//
//  Created by Henry Paulino on 5/23/21.
//

import SwiftUI
import UIKit

let appearance = UINavigationBarAppearance()

struct InstanceItem {
	var id: String
	var label: String
	var main_ip: String
	var os: String
	var status: String
	var power_status: String
}

struct InstancesView: View {
	let instances = [
		InstanceItem(id: "123abc", label: "Stocket Server", main_ip: "123.23.142.1", os: "Ubuntu", status: "active", power_status: "running"),
		InstanceItem(id: "456abc", label: "Stocket Server2", main_ip: "123.23.168.2", os: "Ubuntu", status: "active", power_status: "stopped")
	]
	
	private func powerStatus(_ status: String) -> String {
		return status == "running" ? "play.circle" : "stop.circle"
	}
	
	private func isRunning(_ status: String) -> Bool {
		return status == "running"
	}

    var body: some View {
		NavigationView {
			ScrollView {
				ForEach(instances, id: \.id) { i in
					VStack {
						HStack {
							VStack(alignment: .leading) {
								Text(i.label)
									.fontWeight(.semibold)
									.padding(.bottom, 1)
								Text(i.main_ip)
									.foregroundColor(.gray)
							}
							Spacer()
							VStack {
								Image(systemName: powerStatus(i.power_status))
									.font(.largeTitle)
									.foregroundColor(isRunning(i.power_status) ? .green : .gray)
							}
						}
						
					}
					.frame(maxWidth: .infinity, alignment: .leading)
					.padding(.vertical, 18)
					.padding(.horizontal)
					.background(Color("background_light"))
					.cornerRadius(6)
				}
				Spacer()
				HStack {
					Spacer()
				}
			}
			.padding()
			.navigationTitle("Instances")
		}
    }
}

struct InstancesView_Previews: PreviewProvider {
    static var previews: some View {
		InstancesView()
    }
}
