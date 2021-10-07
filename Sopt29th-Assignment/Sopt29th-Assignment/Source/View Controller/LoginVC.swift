//
//  LoginVC.swift
//  Sopt29th-Assignment
//
//  Created by Thisisme Hi on 2021/10/05.
//

import UIKit
import SnapKit
import Then

class LoginVC: UIViewController {
    // MARK: - Properties
    let logoLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 50)
        $0.textColor = .mainBlue
        $0.text = "Google"
    }
    
    let loginLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 35)
        $0.textColor = .black
        $0.text = "로그인"
    }
    
    let explainLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 16)
        $0.textColor = .lightGray
        $0.numberOfLines = 0
        $0.textAlignment = .center
        $0.text = "YouTube도 이동하며 계속하세요. 앱 및 Safari에서도 Google 서비스에 로그인됩니다."
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
    
    lazy var signUpButton = UIButton().then {
        $0.setTitle("계정만들기", for: .normal)
        $0.setTitleColor(.mainBlue, for: .normal)
        $0.setTitleColor(.white, for: .highlighted)
        $0.titleLabel?.font = .boldSystemFont(ofSize: 16)
        $0.addTarget(self, action: #selector(touchUpSignUpButton(_:)), for: .touchUpInside)
    }
    
    lazy var signInButton = UIButton().then {
        $0.setTitle("다음", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = .boldSystemFont(ofSize: 18)
        $0.backgroundColor = .mainBlue
        $0.layer.cornerRadius = 10
        $0.addTarget(self, action: #selector(touchUpSignInButton(_:)), for: .touchUpInside)
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setupAutoLayout()
        setupTextField()
    }
    
    // MARK: - Custom Method
    func configUI() {
        view.backgroundColor = .white
    }
    
    func setupAutoLayout() {
        view.addSubviews([logoLabel, loginLabel, explainLabel,
                          fieldStackView, signUpButton, signInButton])
        
        logoLabel.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(20)
            make.centerX.equalToSuperview()
        }
        
        loginLabel.snp.makeConstraints { make in
            make.top.equalTo(logoLabel.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
        }
        
        explainLabel.snp.makeConstraints { make in
            make.top.equalTo(loginLabel.snp.bottom).offset(35)
            make.leading.trailing.equalToSuperview().inset(30)
            make.centerX.equalToSuperview()
        }
        
        nameTextField.snp.makeConstraints { make in
            make.height.equalTo(60)
        }
        
        fieldStackView.snp.makeConstraints { make in
            make.top.equalTo(explainLabel.snp.bottom).offset(35)
            make.leading.trailing.equalToSuperview().inset(30)
            make.centerX.equalToSuperview()
        }
        
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(fieldStackView.snp.bottom).offset(110)
            make.leading.equalToSuperview().inset(30)
        }
        
        signInButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(30)
            make.centerY.equalTo(signUpButton.snp.centerY)
            make.width.equalTo(80)
            make.height.equalTo(50)
        }
    }
    
    func setupTextField() {
        nameTextField.delegate = self
        emailTextField.delegate = self
        pwTextField.delegate = self
    }
    
    // MARK: - @objc
    
    @objc func touchUpSignUpButton(_ sender: UIButton) {
        
    }
    
    @objc func touchUpSignInButton(_ sender: UIButton) {
        
    }
}

// MARK: - UITextFieldDelegate
extension LoginVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pwTextField.resignFirstResponder()
        return true
    }
}

