//
//  ContentView.swift
//  Vultr
//
//  Created by Henry Paulino on 5/23/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
		VultrTabView()
//		NavigationView {
//			VStack {
//				Spacer()
//				HStack {
//					Spacer()
//					AddAPIKeyView()
//					Spacer()
//				}
//				Spacer()
//			}
//			.padding(.top, 30)
//			.padding(.bottom, 24)
//			.background(Color("background"))
//			.navigationBarHidden(true)
//			.navigationTitle(Text(""))
//			.edgesIgnoringSafeArea(.all)
//		}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
		ContentView().preferredColorScheme(.dark)
    }
}
