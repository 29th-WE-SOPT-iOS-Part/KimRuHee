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
    
    private let logoImageView = UIImageView().then {
        $0.image = Const.Image.logo
        $0.contentMode = .scaleAspectFit
    }
    
    private let welcomeLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 26, weight: .semibold)
        $0.textAlignment = .center
        $0.numberOfLines = 0
    }
    
    private let completeButton = GoogleButton().then {
        $0.setUI(title: "확인")
        $0.backgroundColor = .mainBlue
        $0.isUserInteractionEnabled = true
        $0.addTarget(self, action: #selector(touchupCompleteButton(_:)), for: .touchUpInside)
    }
    
    private let anotherAccountButton = BaseButton().then {
        $0.setUI(title: "다른 계정으로 로그인하기")
        $0.addTarget(self, action: #selector(touchupAnotherAccountButton(_:)), for: .touchUpInside)
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setupAutoLayout()
        setupData()
    }
    
    // MARK: - Custom Method
    private func configUI() {
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setupAutoLayout() {
        view.addSubviews([logoImageView, welcomeLabel, completeButton, anotherAccountButton])
        
        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(216)
            make.centerX.equalToSuperview()
        }
        
        welcomeLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(23)
            make.leading.trailing.equalToSuperview().inset(22)
            make.centerX.equalToSuperview()
        }
        
        completeButton.snp.makeConstraints { make in
            make.top.equalTo(welcomeLabel.snp.bottom).offset(53)
            make.leading.trailing.equalToSuperview().inset(22)
            make.height.equalTo(42)
        }
        
        anotherAccountButton.snp.makeConstraints { make in
            make.top.equalTo(completeButton.snp.bottom).offset(23)
            make.leading.trailing.equalToSuperview().inset(22)
            make.height.equalTo(22)
        }
    }
    
    func setupData() {
        if let name = name {
            welcomeLabel.text = "\(name)님\n환영합니다!"
            welcomeLabel.addSpacing(kernValue: 0, paragraphValue: 8)
        }
    }
    
    // MARK: - @objc
    @objc func touchupCompleteButton(_ sender: UIButton) {
        let mainVC = MainTabVC()
        mainVC.modalPresentationStyle = .fullScreen
        present(mainVC, animated: true, completion: nil)
    }
    
    @objc func touchupAnotherAccountButton(_ sender: UIButton) {
        do {
            try FirebaseAuth.Auth.auth().signOut()
            guard let pvc = presentingViewController as? UINavigationController else { return }
            self.dismiss(animated: true) {
                pvc.popToRootViewController(animated: true)
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
