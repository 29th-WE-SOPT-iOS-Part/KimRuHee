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
    
    private lazy var homeTV = UITableView().then {
        $0.separatorStyle = .none
        $0.allowsSelection = false
        $0.delegate = self
        $0.dataSource = self
        ChannelTVC.register(target: $0)
        TagTVC.register(target: $0)
        VideoTVC.register(target: $0)
        
        if #available(iOS 15, *) {
            $0.sectionHeaderTopPadding = 0
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setupAutoLayout()
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
                guard let cell = tableView.dequeueReusableCell(withIdentifier: ChannelTVC.className) as? ChannelTVC
                else { return UITableViewCell() }
                return cell
                
            }
            /// TagCell
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TagTVC.className) as? TagTVC
            else { return UITableViewCell() }
            return cell
            
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: VideoTVC.className) as? VideoTVC
            else { return UITableViewCell() }
            cell.setData(thumb: video.list[indexPath.row].makeImage(),
                         title: video.list[indexPath.row].title,
                         sub: video.list[indexPath.row].sub)
            return cell
        }
    }
}
