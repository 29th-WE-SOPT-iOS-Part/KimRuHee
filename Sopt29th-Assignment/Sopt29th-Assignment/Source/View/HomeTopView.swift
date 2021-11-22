//
//  HomeTopView.swift
//  Sopt29th-Assignment
//
//  Created by Thisisme Hi on 2021/10/31.
//

import UIKit

import SnapKit
import Then

/**
    HomeVC의 가장 상단 로고와 메뉴가 있는 Navi View에 해당합니다
 */

// MARK: - Protocol

protocol ProfileButtonDelegate: HomeVC {
    func clickProfileButton()
}

class HomeTopView: UIView {
    
    // MARK: - Properties
    
    public weak var delegate: ProfileButtonDelegate?
    
    private let logoImageView = UIImageView().then {
        $0.image = Const.Image.youtube
    }
    
    private let buttonStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.distribution = .fillEqually
        $0.spacing = 12
    }
    
    private let sharingButton = UIButton().then {
        $0.setImage(Const.Image.sharing, for: .normal)
    }
    
    private let notificationButton = UIButton().then {
        $0.setImage(Const.Image.notification, for: .normal)
    }
    
    private let searchButton = UIButton().then {
        $0.setImage(Const.Image.search, for: .normal)
    }
    
    private lazy var profileButton = UIButton().then {
        $0.setImage(Const.Image.Profile, for: .normal)
        $0.addTarget(self, action: #selector(touchupProfileButton(_:)), for: .touchUpInside)
    }
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
        setupAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Custom Method
    
    private func configUI() {
        backgroundColor = .white
    }
    
    private func setupAutoLayout() {
        addSubviews([logoImageView, buttonStackView, profileButton])
        buttonStackView.addArrangedSubviews([sharingButton, notificationButton, searchButton])
        
        logoImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
        
        buttonStackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(6)
            make.trailing.equalTo(profileButton.snp.leading).offset(-17)
        }
        
        profileButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24)
        } 
    }
    
    // MARK: - @objc
    
    @objc func touchupProfileButton(_ sender: UIButton) {
        delegate?.clickProfileButton()
    }
}
