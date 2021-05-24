//
//  InstanceView.swift
//  Vultr
//
//  Created by Henry Paulino on 5/23/21.
//

import SwiftUI

struct InstanceView: View {
	@EnvironmentObject var vultrAPI: VultrAPI
	var instance: Instance
	
	init(instance: Instance) {
		self.instance = instance
	}
	
	func instanceType() -> String {
		let plan = self.instance.plan
		if (plan.contains("vc2")) {
			return "Cloud Compute"
		} else if (plan.contains("vhf")) {
			return "High Frequency"
		} else if (plan.contains("vdc")) {
			return "Dedicated"
		} else {
			return "NVMe SSD"
		}
	}
	
	func diskType() -> String {
		let plan = self.instance.plan
		if plan.contains("vc2") {
			return "SSD"
		} else if (plan.contains("vhf")) {
			return "NVMe"
		} else if (plan.contains("vdc")) {
			return "Dedicated Cloud"
		} else {
			return "Bare Metal"
		}
	}
	
	func isRunning() -> Bool {
		self.instance.power_status == "running"
	}
	
	func getRegion() -> String {
		let i = self.vultrAPI.regions.firstIndex { $0.id == self.instance.region }
		return self.vultrAPI.regions[i!].city
	}

    var body: some View {
		VStack(alignment: .leading) {
			Text("\(instanceType()) - \(getRegion())")
				.font(.title3)
				.fontWeight(.medium)
				.foregroundColor(.gray)
			
			HStack {
				InstanceActionButton(action: {}, label: isRunning() ? "Stop" : "Start", icon: "power")
				InstanceActionButton(action: {}, label: "Restart", icon: "arrow.triangle.2.circlepath")
			}
			.padding(.top, 20)
			.frame(maxWidth: .infinity)
			
			VStack {
				HStack {
					DetailItem(label: "CPU", value: "\(instance.vcpu_count) vCore")
					Spacer()
					DetailItem(label: "RAM", value: "\(instance.ram) MB")
				}
				HStack {
					DetailItem(label: "Storage", value: "\(instance.disk) GB \(diskType())")
					Spacer()
					DetailItem(label: "Bandwidth", value: "\(instance.allowed_bandwidth) GB")
				}
			}
			.padding(.top, 20)
			.frame(maxWidth: .infinity)
			Spacer()
		}
		.frame(maxWidth: .infinity, alignment: .leading)
		.padding(.horizontal)
		.navigationTitle(instance.label)
    }
}

struct DetailItem: View {
	var label: String
	var value: String
	var body: some View {
		VStack {
			Text(value)
				.fontWeight(.medium)
				.font(.title)
			Text(label)
				.foregroundColor(.gray)
				.fontWeight(.medium)
				.font(.title3)
		}
		.padding(.vertical, 30)
		.frame(width: 170)
		
	}
}

struct InstanceView_Previews: PreviewProvider {
    static var previews: some View {
        InstanceView(instance: Instance(id: "123", os: "Ubuntu", ram: 1024, disk: 32, main_ip: "192.168.21.543", vcpu_count: 1, region: "New Jersey", plan: "vhf-1c-32gb", date_created: "", status: "active", allowed_bandwidth: 2000, netmask_v4: "255.255.252.0", gateway_v4: "192.0.2.1", power_status: "running", server_status: "ok", v6_network: "2001:0db8:1112:18fb::", v6_main_ip: "2001:0db8:1112:18fb:0200:00ff:fe00:0000", v6_network_size: 64, label: "Stocket Server", internal_ip: "", kvm: "", tag: "server", os_id: 215, app_id: 0))
    }
}
