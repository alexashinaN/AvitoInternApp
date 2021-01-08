//
//  OptionsCollectionViewCell.swift
//  AvitoTest
//
//  Created by Violence on 06.01.2021.
//  Copyright © 2021 Violence. All rights reserved.
//

import UIKit

/// Элемент отображения вариантов выделения объявления
final class OptionsCollectionViewCell: UICollectionViewCell {
    
	// MARK: - Private
	
	private let titleLabel = UILabel()
	private let descriptionLabel = UILabel()
	private let priceLabel = UILabel()
	private let iconImageView = UIImageView()
	private let selectIconImageView = UIImageView()
	
	// MARK: - Initialization
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.configure()
		self.setupLayout()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Override
	
	override var isSelected: Bool {
		didSet {
			selectIconImageView.isHidden = !isSelected
		}
	}
	
	override func preferredLayoutAttributesFitting(
		_ layoutAttributes: UICollectionViewLayoutAttributes
	) -> UICollectionViewLayoutAttributes {
		setNeedsLayout()
		layoutIfNeeded()
		let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
		var frame = layoutAttributes.frame
		frame.size.height = ceil(size.height)
		layoutAttributes.frame = frame
		return layoutAttributes
	}
}

// MARK: - Public

extension OptionsCollectionViewCell {
	/// Метод конфигурации ячейки по данным из модели
	/// - Parameter model: Модель
	func configure(with model: OptionsModel.Option) {
		titleLabel.text = model.title
		descriptionLabel.text = model.description
		priceLabel.text = model.price
		selectIconImageView.isHidden = !model.isSelected
		iconImageView.load(url: model.imageUrl)
	}
}

// MARK: - Configure, layout

private extension OptionsCollectionViewCell {
	func configure() {
		selectIconImageView.image = UIImage(named: "checkmark")
		titleLabel.numberOfLines = 0
		titleLabel.font = .boldSystemFont(ofSize: 27)
		titleLabel.textColor = .black
		titleLabel.lineBreakMode = .byWordWrapping
		
		descriptionLabel.numberOfLines = 0
		descriptionLabel.font = .systemFont(ofSize: 16)
		descriptionLabel.textColor = .black
		descriptionLabel.lineBreakMode = .byWordWrapping
		
		priceLabel.numberOfLines = 0
		priceLabel.font = .boldSystemFont(ofSize: 24)
		priceLabel.textColor = .black
		priceLabel.lineBreakMode = .byWordWrapping
		
		contentView.layer.cornerRadius = 10
		contentView.backgroundColor = UIColor(red: 248 / 255, green: 248 / 255, blue: 248 / 255, alpha: 1)
	}
	
	func setupLayout() {
		let stackView = UIStackView()
		stackView.addArrangedSubviews(titleLabel, descriptionLabel, priceLabel)
		stackView.spacing = 15
		stackView.axis = .vertical
		stackView.distribution = .equalSpacing
		
		contentView.addSubviews(iconImageView, stackView, selectIconImageView)
	
		let bottomConstraint = contentView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 15)
		bottomConstraint.priority = .defaultLow
		
		NSLayoutConstraint.activate([
			iconImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
			iconImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15),
			iconImageView.widthAnchor.constraint(equalToConstant: 52),
			iconImageView.heightAnchor.constraint(equalToConstant: 52),
			
			stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
			stackView.leftAnchor.constraint(equalTo: iconImageView.rightAnchor, constant: 15),
			selectIconImageView.leftAnchor.constraint(equalTo: stackView.rightAnchor, constant: 15),
			bottomConstraint,

			selectIconImageView.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor),
			contentView.rightAnchor.constraint(equalTo: selectIconImageView.rightAnchor, constant: 15),
			selectIconImageView.widthAnchor.constraint(equalToConstant: 20),
			selectIconImageView.heightAnchor.constraint(equalToConstant: 20),
		])
	}
}
