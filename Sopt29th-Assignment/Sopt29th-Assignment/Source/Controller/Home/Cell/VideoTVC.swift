//
//  VideoTVC.swift
//  Sopt29th-Assignment
//
//  Created by Thisisme Hi on 2021/11/01.
//

import UIKit

import SnapKit
import Then

/**
 HomeVC의 구독 채널 영상 TableViewCell - 3번째 Cell
 */

class VideoTVC: UITableViewCell {
        
    // MARK: - Properties
    
    private let thumbnailImageView = UIImageView().then {
        $0.contentMode = .scaleToFill
    }
    
    private let profileImageView = UIImageView().then {
        $0.image = Const.Image.Profile
    }
    
    private let titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 15)
        $0.numberOfLines = 2
    }
    
    private let subLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 13)
        $0.textColor = .subTextGray
    }
    
    private let moreButton = UIButton().then {
        $0.setImage(Const.Image.moreMenu, for: .normal)
    }
    
    // MARK: - init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Custom Method
    
    func setupAutoLayout() {
        contentView.addSubviews([thumbnailImageView, profileImageView,
                     titleLabel, subLabel, moreButton])
        
        thumbnailImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(212)
        }
        
        profileImageView.snp.makeConstraints {
            $0.top.equalTo(thumbnailImageView.snp.bottom).offset(11)
            $0.leading.equalToSuperview().inset(12)
            $0.width.height.equalTo(36)
        }
        
        moreButton.snp.makeConstraints {
            $0.top.equalTo(thumbnailImageView.snp.bottom).offset(7)
            $0.trailing.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(profileImageView)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(12)
            $0.trailing.equalToSuperview().inset(45)
        }
        
        subLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.leading.equalTo(titleLabel)
            $0.bottom.equalToSuperview().inset(26)
        }
    }
    
    // MARK: - Set Data
    
    func setData(thumb: UIImage?, title: String, sub: String) {
        thumbnailImageView.image = thumb
        titleLabel.text = title
        subLabel.text = sub
    }
}
