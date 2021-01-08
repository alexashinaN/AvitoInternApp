//
//  UIImageView+URLLoading.swift
//  AvitoTest
//
//  Created by Violence on 07.01.2021.
//  Copyright © 2021 Violence. All rights reserved.
//

import UIKit

extension UIImageView {
	/// Метод позволяющий загружать + отображать картинку по URL, кешируется
	/// - Parameters:
	///   - url: url картинки
	///   - placeholder: плейсхолдер, по умолчанию = nil
	///   - cache: сущность для хранения кеша, по умолчанию = URLCache.shared
	func load(url: URL, placeholder: UIImage? = nil, cache: URLCache = URLCache.shared) {
		let request = URLRequest(url: url)
		if let data = cache.cachedResponse(for: request)?.data, let image = UIImage(data: data) {
			self.image = image
			return
		}
		self.image = placeholder
		URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
			guard
				let data = data,
				let response = response,
				((response as? HTTPURLResponse)?.statusCode ?? 500) < 300,
				let image = UIImage(data: data)
			else { return }
			let cachedData = CachedURLResponse(response: response, data: data)
			cache.storeCachedResponse(cachedData, for: request)
			DispatchQueue.main.async {
				self.image = image
			}
		}).resume()
	}
}
