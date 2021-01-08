//
//  OptionsRouter.swift
//  AvitoTest
//
//  Created by Violence on 07.01.2021.
//  Copyright © 2021 Violence. All rights reserved.
//

import UIKit

final class OptionsRouter {
	
	// MARK: - Private
	
	private weak var rootController: UIViewController?
	
	// MARK: - Initialization
	
	init(rootController: UIViewController) {
		self.rootController = rootController
	}
}

// MARK: - OptionsRouterInput

extension OptionsRouter: OptionsRouterInput {
	func showSelectedOption(_ option: String?) {
		let alert = UIAlertController(title: "Выбрана опция", message: option, preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "Продолжить", style: .default, handler: nil))
		rootController?.present(alert, animated: true, completion: nil)
	}
}
