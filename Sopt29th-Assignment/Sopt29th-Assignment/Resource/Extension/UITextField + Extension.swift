//
//  UITextField + Extension.swift
//  Sopt29th-Assignment
//
//  Created by Thisisme Hi on 2021/10/07.
//

import UIKit

extension UITextField {
    func addLeftPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func setTextField(placeholder: String, secure: Bool) {
        self.placeholder = placeholder
        self.isSecureTextEntry = secure
        self.font = .boldSystemFont(ofSize: 15)
        self.backgroundColor = .white
        self.borderStyle = .line
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 7
        self.clipsToBounds = true
        self.addLeftPadding()
    }
}
