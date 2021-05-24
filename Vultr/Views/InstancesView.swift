//
//  InstancesView.swift
//  Vultr
//
//  Created by Henry Paulino on 5/23/21.
//

import SwiftUI
import UIKit

let appearance = UINavigationBarAppearance()

struct InstancesView: View {
	@EnvironmentObject var vultrAPI: VultrAPI

//	let instances = [
//		Instance(id: "123abc", label: "Stocket Server", main_ip: "123.23.142.1", os: "Ubuntu", status: "active", power_status: "running"),
//		Instance(id: "456abc", label: "Stocket Server2", main_ip: "123.23.168.2", os: "Ubuntu", status: "active", power_status: "stopped")
//	]

    var body: some View {
		NavigationView {
			ScrollView {
				ForEach(vultrAPI.instances, id: \.id) { i in
					InstanceItem(instance: i)
				}
				
				Spacer()
				HStack {
					Spacer()
				}
				
			}
			.padding()
			.navigationTitle("Instances")
			.toolbar(content: {
				Image(systemName: "person.crop.circle")
					.font(.system(size: 32))
					.foregroundColor(Color("vultr_blue"))
			})
		}
		.onAppear {
			vultrAPI.getInstances()
		}
    }
}

struct InstancesView_Previews: PreviewProvider {
    static var previews: some View {
		InstancesView()
    }
}
