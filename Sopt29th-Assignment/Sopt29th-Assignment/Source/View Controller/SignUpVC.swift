//
//  SignUpVC.swift
//  Sopt29th-Assignment
//
//  Created by Thisisme Hi on 2021/10/07.
//

import UIKit
import SnapKit
import Then

class SignUpVC: UIViewController {
    // MARK: - Properties
    let logoLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 50)
        $0.textColor = .mainBlue
        $0.text = "Google"
    }
    
    let signupLabel = UILabel().then {
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
    
    var configShow = UIButton.Configuration.plain()
    
    lazy var showButton = UIButton(configuration: configShow, primaryAction: nil).then {
        $0.addTarget(self, action: #selector(touchupShowButton(_:)), for: .touchUpInside)
        $0.configurationUpdateHandler = { btn in
            var config = btn.configuration
            config?.image = btn.isSelected ? UIImage(systemName: "checkmark.square.fill") : UIImage(systemName: "square")
            btn.configuration = config
        }
    }
    
    lazy var signupButton = UIButton().then {
        $0.isUserInteractionEnabled = false
        $0.setTitle("다음", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = .boldSystemFont(ofSize: 18)
        $0.backgroundColor = .lightGray
        $0.layer.cornerRadius = 10
        $0.addTarget(self, action: #selector(touchupSignupButton(_:)), for: .touchUpInside)
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupButtonConfig()
        setupAutoLayout()
        setupTextField()
    }
    
    // MARK: - Custom Method
    // iOS15에서 나온 새로운 기능 한 번 써봤다...
    func setupButtonConfig() {
        configShow.title = "비밀번호 표시"
        configShow.baseForegroundColor = .black
        configShow.baseBackgroundColor = .clear
        configShow.imagePlacement = .leading
        configShow.imagePadding = 10
    }
    
    func setupAutoLayout() {
        view.addSubviews([logoLabel, signupLabel, fieldStackView,
                          showButton, signupButton])
        
        logoLabel.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(20)
            make.centerX.equalToSuperview()
        }
        
        signupLabel.snp.makeConstraints { make in
            make.top.equalTo(logoLabel.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
        }
        
        nameTextField.snp.makeConstraints { make in
            make.height.equalTo(60)
        }
        
        fieldStackView.snp.makeConstraints { make in
            make.top.equalTo(signupLabel.snp.bottom).offset(80)
            make.leading.trailing.equalToSuperview().inset(30)
            make.centerX.equalToSuperview()
        }
        
        showButton.snp.makeConstraints { make in
            make.top.equalTo(fieldStackView.snp.bottom).offset(10)
            make.leading.equalToSuperview().inset(20)
        }
        
        signupButton.snp.makeConstraints { make in
            make.top.equalTo(fieldStackView.snp.bottom).offset(80)
            make.leading.trailing.equalToSuperview().inset(30)
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
    @objc func textFieldDidChange(textField: UITextField){
        guard let name = nameTextField.text,
              let email = emailTextField.text,
              let pw = pwTextField.text else {
                  return
              }
        
        if name.isEmpty || email.isEmpty || pw.isEmpty {
            signupButton.isUserInteractionEnabled = false
            signupButton.backgroundColor = .lightGray
            print("비활성화")
            
        } else {
            signupButton.isUserInteractionEnabled = true
            signupButton.backgroundColor = .mainBlue
            print("활성화")
        }
    }
    
    @objc func touchupShowButton(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            pwTextField.isSecureTextEntry = false
        } else {
            pwTextField.isSecureTextEntry = true
        }
    }
    
    @objc func touchupSignupButton(_ sender: UIButton) {
        let vc = CompleteVC()
        vc.name = nameTextField.text
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
}

// MARK: - UITextFieldDelegate
extension SignUpVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pwTextField.resignFirstResponder()
        return true
    }
}
