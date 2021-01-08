//
//  OptionService.swift
//  AvitoTest
//
//  Created by Violence on 07.01.2021.
//  Copyright © 2021 Violence. All rights reserved.
//

import Foundation

enum OptionServiceError: Error {
	case urlBroken
}

final class OptionService { }

// MARK: - OptionServiceProtocol

extension OptionService: OptionServiceProtocol {
	func getOptions(completion: @escaping (Result<OptionsResponse, Error>) -> Void) {
		do {
			guard
				let responseUrl = Bundle.main.url(forResource: "Resource", withExtension: "JSON"),
				let jsonData = try String(contentsOf: responseUrl).data(using: .utf8)
			else {
				completion(.failure(OptionServiceError.urlBroken))
				return
			}
			let response = try JSONDecoder().decode(OptionsResponse.self, from: jsonData)
			completion(.success(response))
		} catch {
			completion(.failure(error))
		}
	}
}
