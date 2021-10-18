//
//  UILabel + Extensioin.swift
//  Sopt29th-Assignment
//
//  Created by Thisisme Hi on 2021/10/19.
//

import UIKit

extension UILabel {
    func addSpacing(kernValue: Double, paragraphValue: CGFloat) {
        if let labelText = text, labelText.count > 0 {
            let attributedString = NSMutableAttributedString(string: labelText)
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = paragraphValue
            paragraphStyle.alignment = .center
            attributedString.addAttribute(NSAttributedString.Key.kern,
                                          value: kernValue,
                                          range: NSRange(location: 0,
                                                         length: attributedString.length - 1))
            attributedString.addAttribute(NSAttributedString.Key.paragraphStyle,
                                          value: paragraphStyle,
                                          range: NSMakeRange(0, attributedString.length))
            attributedText = attributedString
            
            if #available(iOS 14.0, *) {
                lineBreakStrategy = .hangulWordPriority
            } else {
                lineBreakMode = .byWordWrapping
            }
        }
    }
}
