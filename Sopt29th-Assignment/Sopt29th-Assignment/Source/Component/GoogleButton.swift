//
//  GoogleButton.swift
//  Sopt29th-Assignment
//
//  Created by Thisisme Hi on 2021/10/19.
//

import UIKit

/**
    배경색이 있는 버튼에 해당합니다
 */
class GoogleButton: UIButton {
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? .mainBlue : .lineGray
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI(title: String) {
        self.setTitle(title, for: .normal)
        self.setTitleColor(.white, for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        self.backgroundColor = .lineGray
        self.isUserInteractionEnabled = false
        self.layer.cornerRadius = 4
    }
}
