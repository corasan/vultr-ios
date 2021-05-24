//
//  Instance.swift
//  Vultr
//
//  Created by Henry Paulino on 5/23/21.
//

import Foundation

struct Instance: Codable {
	var id: String
	var os: String
	var ram: Int
	var disk: Int
	var main_ip: String
	var vcpu_count: Int
	var region: String
	var plan: String
	var date_created: String
	var status: String
	var allowed_bandwidth: Int
	var netmask_v4: String
	var gateway_v4: String
	var power_status: String
	var server_status: String
	var v6_network: String
	var v6_main_ip: String
	var v6_network_size: Int
	var label: String
	var internal_ip: String
	var kvm: String
	var tag: String
	var os_id: Int
	var app_id: Int
}
