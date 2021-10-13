//
//  UIStackView + Extension.swift
//  Sopt29th-Assignment
//
//  Created by Thisisme Hi on 2021/10/14.
//

import UIKit

extension UIStackView {
    public func addArrangedSubviews(_ view: [UIView]) {
        view.forEach{ self.addArrangedSubview($0) }
    }
}
