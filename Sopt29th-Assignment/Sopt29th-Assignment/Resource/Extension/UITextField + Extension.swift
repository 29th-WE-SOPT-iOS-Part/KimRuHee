//
//  UITextField + Extension.swift
//  Sopt29th-Assignment
//
//  Created by Thisisme Hi on 2021/10/07.
//

import UIKit

extension UITextField {
    func addLeftPadding(width: CGFloat = 14) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func addRightPadding(width: CGFloat = 14) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
    func setTextField(placeholder: String, secure: Bool) {
        self.placeholder = placeholder
        self.isSecureTextEntry = secure
        self.font = .systemFont(ofSize: 15, weight: .regular)
        self.backgroundColor = .white
        self.borderStyle = .line
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lineGray.cgColor
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
        self.addLeftPadding()
        self.addRightPadding()
    }
}
