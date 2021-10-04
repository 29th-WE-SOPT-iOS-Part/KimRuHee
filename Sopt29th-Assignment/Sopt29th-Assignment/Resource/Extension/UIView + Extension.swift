//
//  UIView + Extension.swift
//  Sopt29th-Assignment
//
//  Created by Thisisme Hi on 2021/10/05.
//

import UIKit

extension UIView {
    func addSubviews(_ view: [UIView]) {
        view.forEach { self.addSubview($0) }
    }
}
