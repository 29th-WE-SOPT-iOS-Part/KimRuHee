//
//  HomeVC.swift
//  Sopt29th-Assignment
//
//  Created by Thisisme Hi on 2021/10/19.
//

import UIKit

import SnapKit
import Then

class HomeVC: UIViewController {
    
    // MARK: - Properties
    
    private let video = VideoData()
    private let channel = ChannelData()
    
    private let homeTV = UITableView().then {
        $0.separatorStyle = .none
        $0.allowsSelection = false
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setupAutoLayout()
        setupTableView()
    }
    
    // MARK: - Custom Method
    
    private func configUI() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setupAutoLayout() {
        view.addSubview(homeTV)
        
        homeTV.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.leading.bottom.trailing.equalToSuperview()
        }
    }
    
    func setupTableView() {
        homeTV.delegate = self
        homeTV.dataSource = self
        homeTV.register(ChannelTVC.self, forCellReuseIdentifier: Const.Cell.channelTVC)
        homeTV.register(TagTVC.self, forCellReuseIdentifier: Const.Cell.tagTVC)
        homeTV.register(VideoTVC.self, forCellReuseIdentifier: Const.Cell.videoTVC)
        
        if #available(iOS 15, *) {
            homeTV.sectionHeaderTopPadding = 0
        }
    }
}

// MARK: - UITableViewDelegate

extension HomeVC: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    /// Header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            return HomeTopView()
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return UITableView.automaticDimension
        default:
            return 0
        }
    }
    
    /// Footer
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
         return nil
     }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
}

// MARK: - UITableViewDataSource

extension HomeVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 1:
            return video.list.count
        default:
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: Const.Cell.channelTVC) as? ChannelTVC
                else { return UITableViewCell() }
                return cell
                
            }
            /// TagCell
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Const.Cell.tagTVC) as? TagTVC
            else { return UITableViewCell() }
            return cell
            
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Const.Cell.videoTVC) as? VideoTVC
            else { return UITableViewCell() }
            cell.setData(thumb: video.list[indexPath.row].makeImage(),
                         title: video.list[indexPath.row].title,
                         sub: video.list[indexPath.row].sub)
            return cell
        }
    }
}
