//
//  ChannelTVC.swift
//  Sopt29th-Assignment
//
//  Created by Thisisme Hi on 2021/11/01.
//

import UIKit

import SnapKit
import Then

/**
 HomeVC의 구독 채널 스토리 + 필터링 버튼 TableViewCell - 1번째 Cell
 */

class ChannelTVC: UITableViewCell, UITableViewRegisterable {
    
    // MARK: - Properties
    
    private let channel = ChannelData()
    
    private lazy var channelCV = UICollectionView(frame: .zero,
                                                  collectionViewLayout: layout).then {
        $0.showsHorizontalScrollIndicator = false
        $0.delegate = self
        $0.dataSource = self
        ChannelCVC.register(target: $0)
    }
    
    private let layout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
    }
    
    private let lineView = UIView().then {
        $0.backgroundColor = .dividerGray
    }
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Custom Method
    
    func setupAutoLayout() {
        contentView.addSubviews([channelCV, lineView])
        
        channelCV.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(104)
        }
        
        lineView.snp.makeConstraints { make in
            make.leading.bottom.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
    }
}

// MARK: - UICollectionViewDataSource

extension ChannelTVC: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return channel.list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChannelCVC.className, for: indexPath) as? ChannelCVC
        else { return UICollectionViewCell() }
        cell.setData(image: channel.list[indexPath.row].makeImage(),
                     name: channel.list[indexPath.row].name)
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension ChannelTVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 72, height: 104)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat { // 상하간격
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat { // 좌우간격
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
}

