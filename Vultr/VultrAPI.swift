//
//  VultrAPI.swift
//  Vultr
//
//  Created by Henry Paulino on 5/23/21.
//

import Alamofire
import KeychainSwift
import SwiftUI

class VultrAPI: ObservableObject {
	private let url = "https://api.vultr.com/v2"
	private let keychain = KeychainSwift()
	@Published var apiKey: String
	
	init() {
		keychain.synchronizable = true
		apiKey = keychain.get("corasan.vultr-manager.apiKey") ?? ""
	}
	
	private func request(_ endpoint: String, method: HTTPMethod) -> DataRequest {
		let headers: HTTPHeaders = [
			.authorization(bearerToken: self.apiKey)
		]
		return AF.request("\(url)/\(endpoint)", method: method, headers: headers)
	}
	
	func setApiKey(_ key: String) {
		keychain.set(key, forKey: "corasan.vultr-manager.apiKey")
		self.apiKey = key
	}
	
	func account() {
		request("account", method: .get).responseJSON { res in
			debugPrint(res)
		}
	}
}
