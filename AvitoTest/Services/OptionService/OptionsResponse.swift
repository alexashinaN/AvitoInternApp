//
//  OptionsResponse.swift
//  AvitoTest
//
//  Created by Violence on 07.01.2021.
//  Copyright © 2021 Violence. All rights reserved.
//

import Foundation

/// Модель данных по вариантам выделения объявления
struct OptionsResponse: Decodable {
	struct Result: Decodable {
		struct List: Decodable {
			let id: String
			let title: String
			let description: String?
			let icon: Icon
			let price: String
			let isSelected: Bool

			struct Icon: Decodable {
				let urlIcon: String
				
				private enum CodingKeys: String, CodingKey {
					case urlIcon = "52x52"
				}
			}
		}
		
		let title: String
		let actionTitle: String
		let selectedActionTitle: String
		let list: [List]
	}
	
	let status: String
	let result: Result
}
