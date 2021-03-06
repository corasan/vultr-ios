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
	private var headers: HTTPHeaders
	
	@Published var apiKey: String = ""
	@Published var instances: [Instance] = [Instance]()
	@Published var regions: [Region] = [Region]()
	@Published var instance: Instance?
	
	init() {
		keychain.synchronizable = true
		let key: String = keychain.get("corasan.vultr-manager.apiKey") ?? ""
		apiKey = key
		headers = [
			.authorization(bearerToken: key)
		]
	}
	
	private func request(_ path: String, method: HTTPMethod) -> DataRequest {
		return AF.request("\(url)/\(path)", method: method, headers: headers)
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
					self.instances = arr.map { try! self.decodeJSON(Instance.self, json: $0) }.reversed()
				case let .failure(err):
					print(err)
			}
		}
	}
	
	func getRegions() {
		request("regions", method: .get).responseJSON { res in
			switch res.result {
				case let .success(result):
					let resultJSON = result as! [String: Any]
					let arr = resultJSON["regions"] as! [[String: Any]]
					self.regions = arr.map { try! self.decodeJSON(Region.self, json: $0) }
				case let .failure(err):
					debugPrint(err)
			}
		}
	}
	
	func start(instanceId: String) {
		request("instances/\(instanceId)/start", method: .post).responseJSON { res in
			switch res.result {
				case .success:
					self.changeStatus(id: instanceId)
				case let .failure(err):
					debugPrint(err)
			}
		}
	}
	
	func stop(instanceId: String) {
		let params: [String: [String]] = ["instance_ids": [instanceId]]
		AF.request(
			"\(url)/instances/halt",
			method: .post,
			parameters: params,
			encoder: JSONParameterEncoder.default,
			headers: headers
		).responseJSON { res in
			switch res.result {
				case .success:
					self.changeStatus(id: instanceId)
				case let .failure(err):
					debugPrint(err)
			}
		}
	}
	
	func getInstance(instance_id: String) {
		request("instances/\(instance_id)", method: .get).responseJSON { res in
			switch res.result {
				case let .success(result):
					let resultJSON = result as! [String: Any]
					let json = resultJSON["instance"]! as! [String: Any]
					debugPrint(json)
					self.instance = try! self.decodeJSON(Instance.self, json: json)
				case let .failure(err):
					debugPrint(err)
			}
		}
	}
	
	private func replaceWithNewInstance(instance: Instance) {
		let i = self.instances.firstIndex { $0.id == instance.id }
		self.instances[i!] = instance
	}
	
	private func changeStatus(id: String) {
		let i = self.instances.firstIndex { $0.id == id }
		let status = self.instances[i!].power_status
		self.instances[i!].power_status = status == "running" ? "stopped" : "running"
	}
}
