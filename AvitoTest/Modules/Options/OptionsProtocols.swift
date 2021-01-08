//
//  OptionsProtocols.swift
//  AvitoTest
//
//  Created by Violence on 07.01.2021.
//  Copyright © 2021 Violence. All rights reserved.
//

import Foundation

///presenter -> view
protocol OptionsViewInput: class {
	/// Метод сообщает вью о том, что необходимо отобразить данные
	func displayData()
	
	/// Метод сообщает вью о том, что необходимо снять выделение по индексу
	/// - Parameter index: Индекс
	func deselectItem(at index: IndexPath)
	
	/// Метод установки заголовка кнопки
	/// - Parameter title: Заголовок
	func setButton(title: String)
}

///view -> presenter
protocol OptionsViewOutput {
	/// Метод сообщает презентору о том, что вью загрузилось
	func viewLoaded()
	
	/// Метод сообщает презентору о нажатии на кнопку "выбрать"
	func selectButtonDidTap()
	
	/// Метод получения количества элементов в секции по индексу
	/// - Parameter section: Индекс секции
	func numberOfItems(section: Int) -> Int
	
	/// Метод получения модели данных для отображения по индексу
	/// - Parameter index: Индекс
	func modelForItem(at index: IndexPath) -> OptionsModel.Option?
	
	/// Метод сообщает презентору о выборе элемента по индексу
	/// - Parameter index: Индекс
	func itemDidSelect(at index: IndexPath)
	
	/// Метод получения заголовка секции по индексу
	/// - Parameter section: Индекс секции
	func titleForHeader(at section: Int) -> String
}

/// presenter -> interactor
protocol OptionsInteractorInput {
	///Метод запроса данных у интератора
	func requestOptions()
}

/// interactor -> presenter
protocol OptionsInteractorOutput: class {
	/// Метод обработки запрошенных данных
	/// - Parameter response: Данные
	func processingResponse(_ response: OptionsResponse)
}

/// presenter -> router
protocol OptionsRouterInput {
	/// Метод отображения выбранной опции выделения объявления
	/// - Parameter option: Выбранная опция
	func showSelectedOption(_ option: String?) 
}
