//
//  OptionsViewController.swift
//  AvitoTest
//
//  Created by Violence on 07.01.2021.
//  Copyright © 2021 Violence. All rights reserved.
//

import UIKit

final class OptionsViewController: UIViewController {
	
	// MARK: - Private
	
	private let closeImage = UIImageView()
	private let chooseButton = UIButton()
	private let output: OptionsViewOutput
	
	private let optionsCollectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.sectionInset = UIEdgeInsets(top: 5, left: 15, bottom: 5, right: 15)
		layout.estimatedItemSize = CGSize(width: UIScreen.main.bounds.width - 30, height: 100)
		layout.headerReferenceSize = layout.estimatedItemSize
		layout.scrollDirection = .vertical

		let optionsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		optionsCollectionView.register(OptionsCollectionViewCell.self, forCellWithReuseIdentifier: "optionsCell")
		optionsCollectionView.register(HeaderCollectionView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerCell")
		return optionsCollectionView
	}()
	
	// MARK: - Initialization
	
	init(output: OptionsViewOutput) {
		self.output = output
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Lifecycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configure()
		setupLayout()
		output.viewLoaded()
	}
}

// MARK: - OptionsViewInput

extension OptionsViewController: OptionsViewInput {
	func setButton(title: String) {
		chooseButton.setTitle(title, for: .normal)
	}
	
	func deselectItem(at index: IndexPath) {
		optionsCollectionView.deselectItem(at: index, animated: true)
	}
	
	func displayData() {
		optionsCollectionView.reloadData()
	}
}

// MARK: - Configure, layout

private extension OptionsViewController {
	func configure() {
		view.backgroundColor = .white
		closeImage.image = UIImage(named: "closeIcon")
		chooseButton.backgroundColor = UIColor(red: 73 / 255, green: 172 / 255, blue: 255 / 255, alpha: 1)
		chooseButton.layer.cornerRadius = 7
		chooseButton.setTitleColor(.white, for: .normal)
		chooseButton.addTarget(self, action: #selector(chooseButtonTapped), for: .touchUpInside)
		optionsCollectionView.backgroundColor = .clear
		optionsCollectionView.dataSource = self
		optionsCollectionView.delegate = self
		optionsCollectionView.contentInset.bottom = 80
	}
	
	func setupLayout() {
		view.addSubviews(optionsCollectionView, closeImage, chooseButton)
		
		NSLayoutConstraint.activate([
			closeImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
			closeImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
			closeImage.widthAnchor.constraint(equalToConstant: 24),
			closeImage.heightAnchor.constraint(equalToConstant: 24),
			
			optionsCollectionView.topAnchor.constraint(equalTo: closeImage.bottomAnchor, constant: 30),
			optionsCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
			view.rightAnchor.constraint(equalTo: optionsCollectionView.rightAnchor),
			view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: optionsCollectionView.bottomAnchor),
			
			chooseButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
			view.rightAnchor.constraint(equalTo: chooseButton.rightAnchor, constant: 15),
			view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: chooseButton.bottomAnchor, constant: 15),
			chooseButton.heightAnchor.constraint(equalToConstant: 50)
		])
	}
}

// MARK: - Actions

private extension OptionsViewController {
	@objc func chooseButtonTapped(sender: UIButton) {
		output.selectButtonDidTap()
	}
}

// MARK: - UICollectionViewDataSource

extension OptionsViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return output.numberOfItems(section: section)
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		if
			let itemCell = collectionView.dequeueReusableCell(withReuseIdentifier: "optionsCell", for: indexPath) as? OptionsCollectionViewCell,
			let model = output.modelForItem(at: indexPath)
		{
			itemCell.configure(with: model)
			return itemCell
		}
		return UICollectionViewCell()
	}
	
	func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
		guard
			kind == UICollectionView.elementKindSectionHeader,
			let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerCell", for: indexPath) as? HeaderCollectionView
		else {
			return UICollectionReusableView()
		}
		headerView.configure(with: output.titleForHeader(at: indexPath.section))
		return headerView
	}
}

// MARK: - UICollectionViewDelegate

extension OptionsViewController: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		output.itemDidSelect(at: indexPath)
	}
}

// MARK: - UICollectionViewDelegateFlowLayout

extension OptionsViewController: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
		guard
			let headerView = self.collectionView(
				collectionView,
				viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionHeader,
				at: IndexPath(row: 0, section: section)
				) as? HeaderCollectionView
		else {
			return .zero
		}
		return headerView.systemLayoutSizeFitting(CGSize(width: collectionView.frame.width, height: UIView.layoutFittingExpandedSize.height),
												  withHorizontalFittingPriority: .required,
												  verticalFittingPriority: .fittingSizeLevel)
	}
}
