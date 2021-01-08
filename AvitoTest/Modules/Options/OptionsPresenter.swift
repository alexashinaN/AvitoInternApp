//
//  OptionsPresenter.swift
//  AvitoTest
//
//  Created by Violence on 07.01.2021.
//  Copyright © 2021 Violence. All rights reserved.
//

import Foundation

final class OptionsPresenter {
	
	// MARK: - Private
	
	private let router: OptionsRouterInput
	private let interactor: OptionsInteractorInput
	private var model: OptionsModel?
	
	weak var view: OptionsViewInput?
	
	// MARK: - Initialization
	
	init(router: OptionsRouterInput, interactor: OptionsInteractorInput) {
		self.router = router
		self.interactor = interactor
	}
}

// MARK: - OptionsViewOutput

extension OptionsPresenter: OptionsViewOutput {
	func itemDidSelect(at index: IndexPath) {
		guard let model = model else { return }
		let modelToSelect = model.optionsModel[index.row]
		if modelToSelect.isSelected {
			view?.deselectItem(at: index)
		} else {
			model.optionsModel
				.filter { $0.isSelected }
				.forEach { $0.isSelected.toggle() }
		}
		modelToSelect.isSelected.toggle()
		view?.setButton(title: modelToSelect.isSelected ? model.selectedActionTitle : model.actionTitle)
	}
	
	func modelForItem(at index: IndexPath) -> OptionsModel.Option? {
		return model?.optionsModel[index.row]
	}
	
	func numberOfItems(section: Int) -> Int {
		return model?.optionsModel.count ?? 0
	}
	
	func viewLoaded() {
		interactor.requestOptions()
	}
	
	func selectButtonDidTap() {
		router.showSelectedOption(model?.optionsModel.first(where: { $0.isSelected })?.title ?? "Не выбрано")
	}
	
	func titleForHeader(at section: Int) -> String {
		return model?.header ?? ""
	}
}

// MARK: - OptionsInteractorOutput

extension OptionsPresenter: OptionsInteractorOutput {
	func processingResponse(_ response: OptionsResponse) {
		let model = OptionsModel(response: response)
		self.model = model
		view?.setButton(title: model.actionTitle)
		view?.displayData()
	}	
}
