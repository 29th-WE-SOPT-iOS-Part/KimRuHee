//
//  LoginVC.swift
//  Sopt29th-Assignment
//
//  Created by Thisisme Hi on 2021/10/05.
//

import UIKit

import Firebase
import FirebaseAuth
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
        $0.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
    }
    
    let emailTextField = UITextField().then {
        $0.setTextField(placeholder: "이메일 또는 휴대전화", secure: false)
        $0.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
    }
    
    let pwTextField = UITextField().then {
        $0.setTextField(placeholder: "비밀번호 입력", secure: true)
        $0.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
    }
    
    let signupButton = UIButton().then {
        $0.setTitle("계정만들기", for: .normal)
        $0.setTitleColor(.mainBlue, for: .normal)
        $0.setTitleColor(.white, for: .highlighted)
        $0.titleLabel?.font = .boldSystemFont(ofSize: 16)
        $0.addTarget(self, action: #selector(touchupSignupButton(_:)), for: .touchUpInside)
    }
    
    let signInButton = UIButton().then {
        $0.isUserInteractionEnabled = false
        $0.setTitle("다음", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = .boldSystemFont(ofSize: 18)
        $0.backgroundColor = .lightGray
        $0.layer.cornerRadius = 10
        $0.addTarget(self, action: #selector(touchupSignInButton(_:)), for: .touchUpInside)
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setupAutoLayout()
        hideKeyboard()
    }
    
    // MARK: - Custom Method
    func configUI() {
        view.backgroundColor = .white
    }
    
    func setupAutoLayout() {
        view.addSubviews([logoLabel, loginLabel, explainLabel,
                          fieldStackView, signupButton, signInButton])
        
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
        
        signupButton.snp.makeConstraints { make in
            make.top.equalTo(fieldStackView.snp.bottom).offset(110)
            make.leading.equalToSuperview().inset(30)
        }
        
        signInButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(30)
            make.centerY.equalTo(signupButton.snp.centerY)
            make.width.equalTo(80)
            make.height.equalTo(50)
        }
    }
    
    func getUserProfile() {
        // 사용자 프로필 가져오기
        if let currentEmail = FirebaseAuth.Auth.auth().currentUser?.email {
            let vc = CompleteVC()
            print("파이어베이스 로그인 성공", currentEmail)
            vc.name = nameTextField.text
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        }
    }
    
    // MARK: - @objc
    @objc func textFieldDidChange(textField: UITextField){
        guard let name = nameTextField.text,
              let email = emailTextField.text,
              let pw = pwTextField.text else {
                  return
              }
        
        if name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
            email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
            pw.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            signInButton.isUserInteractionEnabled = false
            signInButton.backgroundColor = .lightGray
            
        } else {
            signInButton.isUserInteractionEnabled = true
            signInButton.backgroundColor = .mainBlue
        }
    }
    
    @objc func touchupSignupButton(_ sender: UIButton) {
        let vc = SignUpVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func touchupSignInButton(_ sender: UIButton) {
        guard let email = emailTextField.text, !email.isEmpty,
              let pw = pwTextField.text, !pw.isEmpty else {
                  print("이메일과 패스워드를 입력해주세요.")
                  return
              }
        
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: pw) { [weak self] user, error in
            guard let self = self else { return }
            // 에러가 나거나 유저가 없을 경우
            if let error = error, user == nil {
                let alert = UIAlertController(
                    title: "로그인 실패",
                    message: error.localizedDescription,
                    preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "확인", style: .default))
                self.present(alert, animated: true, completion: nil)
                
            } else { // 성공이면 화면전환하고 프로필 가져오기
                self.getUserProfile()
            }
        }
    }
}

