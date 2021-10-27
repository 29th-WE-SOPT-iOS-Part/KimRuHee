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
    private let logoImageView = UIImageView.then {
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
    }
    
    private func setupAutoLayout() {
        
    }
}
