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
	@Published var instances: [Instance] = [Instance]()
	
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
	
	func getInstances() {
		request("instances", method: .get).responseJSON { res in
			switch res.result {
				case let .success(result):
					let data = result as! [String: Any]
					let arr = data["instances"]! as! [[String: Any]]
					
					self.instances = arr.map { el in
						let convertedData = try! JSONSerialization.data(withJSONObject: el, options: JSONSerialization.WritingOptions.prettyPrinted)
						let dataStr = String(data: convertedData, encoding: String.Encoding.utf8)
						let json = Data(dataStr!.utf8)
						return try! JSONDecoder().decode(Instance.self, from: json)
					}.reversed()
				case let .failure(err):
					print(err)
			}
		}
	}
}
