//
//  OptionsModel.swift
//  AvitoTest
//
//  Created by Violence on 06.01.2021.
//  Copyright © 2021 Violence. All rights reserved.
//

import UIKit

/// Модель данных по вариантам выделения объявления для модуля Options
struct OptionsModel {
	final class Option {
		let title: String
		let description: String?
		let price: String
		let imageUrl: URL
		var isSelected = false
		
		init?(_ list: OptionsResponse.Result.List) {
			guard let url = URL(string: list.icon.urlIcon) else { return nil }
			self.title = list.title
			self.description = list.description
			self.price = list.price
			self.imageUrl = url
		}
	}
	
	let header: String
	let optionsModel: [Option]
	let actionTitle: String
	let selectedActionTitle: String
	
	init(response: OptionsResponse) {
		self.header = response.result.title
		self.actionTitle = response.result.actionTitle
		self.selectedActionTitle = response.result.selectedActionTitle
		self.optionsModel = response.result.list
			.filter { $0.isSelected }
			.compactMap { Option($0) }
	}
}
