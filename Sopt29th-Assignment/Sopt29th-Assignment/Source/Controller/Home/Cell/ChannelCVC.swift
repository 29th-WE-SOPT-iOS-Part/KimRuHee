//
//  ChannelCVC.swift
//  Sopt29th-Assignment
//
//  Created by Thisisme Hi on 2021/11/01.
//

import UIKit

import SnapKit
import Then

/**
 ChannelTVC에 있는 ChannelCV의 구독 채널 스토리 CollectionViewCell
 */

class ChannelCVC: UICollectionViewCell {
        
    // MARK: - Properties
    
    private let channelImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
    private let nameLabel = UILabel().then {
        $0.textAlignment = .center
        $0.textColor = .subTextGray
        $0.font = .systemFont(ofSize: 12, weight: .regular)
    }
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Custom Method

    func setupAutoLayout() {
        contentView.addSubviews([channelImageView, nameLabel])
        
        channelImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(14)
            make.leading.trailing.equalToSuperview().inset(7)
            make.width.height.equalTo(58)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(channelImageView.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview().inset(7)
            make.bottom.equalToSuperview().inset(14)
        }
    }
    
    // MARK: - Set Data
    
    func setData(image: UIImage?, name: String) {
        channelImageView.image = image
        nameLabel.text = name
    }
}
