//
//  OptionsConfigurator.swift
//  AvitoTest
//
//  Created by Violence on 07.01.2021.
//  Copyright © 2021 Violence. All rights reserved.
//

import UIKit

final class OptionsConfigurator {
	func makeOptionsModule(with controller: UIViewController) -> UIViewController {
		let router = OptionsRouter(rootController: controller)
		let interactor = OptionsInteractor(service: OptionService())
		let presenter = OptionsPresenter(router: router, interactor: interactor)
		let view = OptionsViewController(output: presenter)
		presenter.view = view
		interactor.output = presenter
		return view		
	}
}
