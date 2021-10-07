//
//  SignUpVC.swift
//  Sopt29th-Assignment
//
//  Created by Thisisme Hi on 2021/10/07.
//

import UIKit
import SnapKit
import Then
import SwiftUI

class SignUpVC: UIViewController {
    // MARK: - Properties
    let logoLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 50)
        $0.textColor = .mainBlue
        $0.text = "Google"
    }
    
    let signUpLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 35)
        $0.textColor = .black
        $0.text = "회원가입"
    }
    
    private lazy var fieldStackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .fill
        $0.distribution = .fillEqually
        $0.spacing = 20
        $0.addArrangedSubview(nameTextField)
        $0.addArrangedSubview(emailTextField)
        $0.addArrangedSubview(pwTextField)
    }
    
    let nameTextField = UITextField().then {
        $0.setTextField(placeholder: "이름을 입력해주세요", secure: false)
    }
    
    let emailTextField = UITextField().then {
        $0.setTextField(placeholder: "이메일 또는 휴대전화", secure: false)
    }
    
    let pwTextField = UITextField().then {
        $0.setTextField(placeholder: "비밀번호 입력", secure: true)
    }
    
    var config = UIButton.Configuration.plain()
    
    lazy var showPWButton = UIButton(configuration: config, primaryAction: nil).then {
        $0.addTarget(self, action: #selector(touchUpShowPWButton(_:)), for: .touchUpInside)
        $0.configurationUpdateHandler = { btn in
            var config = btn.configuration
            config?.image = btn.isSelected ? UIImage(systemName: "checkmark.square.fill") : UIImage(systemName: "square")
            btn.configuration = config
        }
    }
    
    lazy var signUpButton = UIButton().then {
        $0.setTitle("다음", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = .boldSystemFont(ofSize: 18)
        $0.backgroundColor = .mainBlue
        $0.layer.cornerRadius = 10
        $0.addTarget(self, action: #selector(touchUpSignUpButton(_:)), for: .touchUpInside)
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setupAutoLayout()
    }
    
    // MARK: - Custom Method
    func configUI() {
        view.backgroundColor = .white
        
        // iOS15에서 나온 새로운 기능
        config.imagePlacement = .leading
        config.imagePadding = 10
        config.title = "비밀번호 표시"
        config.baseForegroundColor = .black
        config.baseBackgroundColor = .clear
    }
        
    func setupAutoLayout() {
        view.addSubviews([logoLabel, signUpLabel, fieldStackView,
                          showPWButton, signUpButton])
        
        logoLabel.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(20)
            make.centerX.equalToSuperview()
        }
        
        signUpLabel.snp.makeConstraints { make in
            make.top.equalTo(logoLabel.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
        }
        
        nameTextField.snp.makeConstraints { make in
            make.height.equalTo(60)
        }
        
        fieldStackView.snp.makeConstraints { make in
            make.top.equalTo(signUpLabel.snp.bottom).offset(80)
            make.leading.trailing.equalToSuperview().inset(30)
            make.centerX.equalToSuperview()
        }
        
        showPWButton.snp.makeConstraints { make in
            make.top.equalTo(fieldStackView.snp.bottom).offset(10)
            make.leading.equalToSuperview().inset(20)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(fieldStackView.snp.bottom).offset(80)
            make.leading.trailing.equalToSuperview().inset(30)
            make.width.equalTo(80)
            make.height.equalTo(50)
        }
    }
    
    // MARK: - @objc
    @objc func touchUpSignUpButton(_ sender: UIButton) {
        
    }
    
    @objc func touchUpShowPWButton(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            pwTextField.isSecureTextEntry = false
        } else {
            pwTextField.isSecureTextEntry = true
        }
    }
}

