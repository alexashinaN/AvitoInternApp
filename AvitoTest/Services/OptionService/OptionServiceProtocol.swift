//
//  OptionServiceProtocol.swift
//  AvitoTest
//
//  Created by Violence on 07.01.2021.
//  Copyright © 2021 Violence. All rights reserved.
//

import Foundation

protocol OptionServiceProtocol {
	/// Метод  запроса данных по вариантам выделения объявления
	/// - Parameter completion: Результат запроса
	func getOptions(completion: @escaping (Result<OptionsResponse, Error>) -> Void)
}
