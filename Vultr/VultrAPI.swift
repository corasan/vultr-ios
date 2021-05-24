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
	@Published var regions: [Region] = [Region]()
	
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
	
	private func decodeJSON<T: Decodable>(_ from: T.Type, json: [String: Any]) throws -> T {
		let convertedData = try! JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted)
		let dataStr = String(data: convertedData, encoding: String.Encoding.utf8)
		return try JSONDecoder().decode(T.self, from: Data(dataStr!.utf8))
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
					let resultJSON = result as! [String: Any]
					let arr = resultJSON["instances"]! as! [[String: Any]]
					self.instances = arr.map { try! self.decodeJSON(Instance.self, json: $0) }
				case let .failure(err):
					print(err)
			}
		}
	}
	
	func getRegions() {
		request("regions", method: .get).responseJSON { res in
			switch res.result {
				case let .success(result):
					debugPrint(result)
					let resultJSON = result as! [String: Any]
					let arr = resultJSON["regions"] as! [[String: Any]]
					self.regions = arr.map { try! self.decodeJSON(Region.self, json: $0) }
				case let .failure(err):
					debugPrint(err)
			}
		}
	}
}
