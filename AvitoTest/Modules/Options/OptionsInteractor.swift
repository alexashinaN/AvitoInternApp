//
//  OptionsInteractor.swift
//  AvitoTest
//
//  Created by Violence on 07.01.2021.
//  Copyright © 2021 Violence. All rights reserved.
//

import Foundation

final class OptionsInteractor {
	
	// MARK: - Private
	
	private let service: OptionServiceProtocol
	
	weak var output: OptionsInteractorOutput?
	
	// MARK: - Initialization
	
	init(service: OptionServiceProtocol) {
		self.service = service
	}
}

// MARK: - OptionsInteractorInput

extension OptionsInteractor: OptionsInteractorInput {
	func requestOptions() {
		service.getOptions { [output] result in
			switch result {
			case let .success(response):
				output?.processingResponse(response)
			case let .failure(error):
				print(error)
			}
		}
	}
}
