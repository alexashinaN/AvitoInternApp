//
//  HeaderCollectionView.swift
//  AvitoTest
//
//  Created by Violence on 08.01.2021.
//  Copyright © 2021 Violence. All rights reserved.
//

import UIKit

/// Элемент отображения хэдэра collectionView
final class HeaderCollectionView: UICollectionReusableView {
	
	// MARK: - Private
	
	private let titleLabel = UILabel()
	
	// MARK: - Initialization
	
	override init(frame: CGRect) {
		super.init(frame: .zero)
		configure()
		setupLayout()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

// MARK: - Public

extension HeaderCollectionView {
	/// Конфигурация хэдэра по данным заголовка
	/// - Parameter title: Заголовок
	func configure(with title: String) {
		titleLabel.text = title
	}
}

// MARK: - Configure, layout

private extension HeaderCollectionView {
	func configure() {
		titleLabel.font = .boldSystemFont(ofSize: 30)
		titleLabel.numberOfLines = 0
	}
	
	func setupLayout() {
		addSubviews(titleLabel)
		
		NSLayoutConstraint.activate([
			titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
			rightAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: 40),
			titleLabel.topAnchor.constraint(equalTo: topAnchor),
			bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30)
		])
	}
}
