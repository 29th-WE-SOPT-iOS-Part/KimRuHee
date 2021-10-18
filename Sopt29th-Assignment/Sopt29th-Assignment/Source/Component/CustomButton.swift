//
//  CustomButton.swift
//  Sopt29th-Assignment
//
//  Created by Thisisme Hi on 2021/10/19.
//

import UIKit

class CustomButton: UIButton {
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? .lineGray : .mainBlue
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configUI() {
        self.isUserInteractionEnabled = false
        self.layer.cornerRadius = 4
        self.setTitleColor(.white, for: .normal)
        self.backgroundColor = .lineGray
        self.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
    }
}
