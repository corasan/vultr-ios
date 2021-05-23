//
//  VultrTabView.swift
//  Vultr
//
//  Created by Henry Paulino on 5/23/21.
//

import SwiftUI

struct VultrTabView: View {
    var body: some View {
		TabView {
			InstancesView()
				.tabItem {
					Label("Instances", systemImage: "cpu")
				}
				.tag(0)
			ProfileView()
				.tabItem {
					Label("Profile", systemImage: "person.fill")
				}
				.tag(1)
				
		}
		.accentColor(Color("vultr_blue"))
		
    }
}

struct VultrTabView_Previews: PreviewProvider {
    static var previews: some View {
		VultrTabView()
    }
}
