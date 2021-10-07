//
//  CompleteVC.swift
//  Sopt29th-Assignment
//
//  Created by Thisisme Hi on 2021/10/07.
//

import UIKit

import Firebase
import FirebaseAuth
import SnapKit
import Then

class CompleteVC: UIViewController {
    // MARK: - Properties
    var name: String?
    
    private var logoLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 50)
        $0.textColor = .mainBlue
        $0.text = "Google"
    }
    
    private var welcomeLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 35)
        $0.textColor = .black
        $0.textAlignment = .center
        $0.numberOfLines = 2
    }
    
    let completeButton = UIButton().then {
        $0.setTitle("확인", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = .boldSystemFont(ofSize: 18)
        $0.backgroundColor = .mainBlue
        $0.layer.cornerRadius = 10
        $0.addTarget(self, action: #selector(touchupCompleteButton(_:)), for: .touchUpInside)
    }
    
    let logoutButton = UIButton().then {
        $0.setTitle("로그아웃", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = .boldSystemFont(ofSize: 18)
        $0.backgroundColor = .mainBlue
        $0.layer.cornerRadius = 10
        $0.addTarget(self, action: #selector(touchupLogoutButton(_:)), for: .touchUpInside)
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setupAutoLayout()
        setupData()
    }
    
    // MARK: - Custom Method
    func configUI() {
        view.backgroundColor = .white
    }
    
    func setupAutoLayout() {
        view.addSubviews([logoLabel, welcomeLabel, completeButton, logoutButton])
        
        logoLabel.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(100)
            make.centerX.equalToSuperview()
        }
        
        welcomeLabel.snp.makeConstraints { make in
            make.top.equalTo(logoLabel.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(80)
            make.centerX.equalToSuperview()
        }
        
        completeButton.snp.makeConstraints { make in
            make.top.equalTo(welcomeLabel.snp.bottom).offset(80)
            make.leading.trailing.equalToSuperview().inset(30)
            make.width.equalTo(80)
            make.height.equalTo(50)
        }
        
        logoutButton.snp.makeConstraints { make in
            make.top.equalTo(completeButton.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(30)
            make.width.equalTo(80)
            make.height.equalTo(50)
        }
    }
    
    func setupData() {
        if let name = name {
            welcomeLabel.text = "\(name)님\n환영합니다!"
        }
    }
    
    // MARK: - @objc
    @objc func touchupCompleteButton(_ sender: UIButton) {
        
    }
    
    @objc func touchupLogoutButton(_ sender: UIButton) {
        do { // 로그아웃
            try FirebaseAuth.Auth.auth().signOut()
            dismiss(animated: true, completion: nil)
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
