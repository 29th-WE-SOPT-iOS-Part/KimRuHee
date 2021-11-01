//
//  BaseButton.swift
//  Sopt29th-Assignment
//
//  Created by Thisisme Hi on 2021/10/27.
//

import UIKit

/**
    배경색이 없는 버튼에 해당합니다
 */

class BaseButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI(title: String) {
        self.setTitle(title, for: .normal)
        self.setTitleColor(.mainBlue, for: .normal)
        self.setTitleColor(.white, for: .highlighted)
        self.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
    }
}
