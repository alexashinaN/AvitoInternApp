//
//  UIView+Extension.swift
//  AvitoTest
//
//  Created by Violence on 06.01.2021.
//  Copyright © 2021 Violence. All rights reserved.
//

import UIKit

extension UIView {
	func addSubviews(_ views: UIView...) {
		views.forEach {
			addSubview($0)
			$0.translatesAutoresizingMaskIntoConstraints = false
		}
	}
}

extension UIStackView {
	func addArrangedSubviews(_ views: UIView...) {
		views.forEach {
			addArrangedSubview($0)
		}
	}
}
