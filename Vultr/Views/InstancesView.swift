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

    var body: some View {
		NavigationView {
			ScrollView {
				ForEach(vultrAPI.instances, id: \.id) { i in
					NavigationLink(destination: InstanceView(instance: i).environmentObject(vultrAPI)) {
						InstanceItem(instance: i)
					}
					.foregroundColor(Color("font"))
					.simultaneousGesture(TapGesture().onEnded {
						self.vultrAPI.getInstance(instance_id: i.id)
					})
				}
				Spacer()
				HStack { Spacer() }
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
			vultrAPI.getRegions()
		}
    }
}

struct InstancesView_Previews: PreviewProvider {
    static var previews: some View {
		InstancesView()
			.environmentObject(VultrAPI())
    }
}
