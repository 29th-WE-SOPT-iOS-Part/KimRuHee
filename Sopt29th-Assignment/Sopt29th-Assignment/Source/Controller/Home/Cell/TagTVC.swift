//
//  TagTVC.swift
//  Sopt29th-Assignment
//
//  Created by Thisisme Hi on 2021/11/01.
//

import UIKit

import SnapKit
import Then

/**
 HomeVC의 필터링 버튼 TableViewCell - 2번째 Cell
 */

class TagTVC: UITableViewCell, UITableViewRegisterable {
    
    // MARK: - Properties
        
    private lazy var tagScrollView = UIScrollView().then {
        $0.showsHorizontalScrollIndicator = false
    }
    
    private lazy var tagStackView = UIStackView().then {
        $0.spacing = 9
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.distribution = .equalSpacing
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
        contentView.addSubviews([tagScrollView, lineView])
        tagScrollView.addSubview(tagStackView)
        tagStackView.addArrangedSubviews([Const.Tag.all, Const.Tag.today,
                                          Const.Tag.keep, Const.Tag.pause,
                                          Const.Tag.live, Const.Tag.post])
        
        tagScrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(48)
        }
        
        tagStackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(8)
            make.leading.trailing.equalToSuperview().inset(13)
        }
        
        lineView.snp.makeConstraints { make in
            make.leading.bottom.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
    }
}
