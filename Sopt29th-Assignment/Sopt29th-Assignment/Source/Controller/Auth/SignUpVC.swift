//
//  SignUpVC.swift
//  Sopt29th-Assignment
//
//  Created by Thisisme Hi on 2021/10/07.
//

import UIKit

import Firebase
import FirebaseAuth
import FirebaseFirestore
import SnapKit
import Then

class SignUpVC: UIViewController {
    
    // MARK: - Properties
    
    private let logoImageView = UIImageView().then {
        $0.image = Const.Image.logo
        $0.contentMode = .scaleAspectFit
    }
    
    private let signupLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 24, weight: .semibold)
        $0.text = "회원가입"
    }
    
    private let fieldStackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .fill
        $0.distribution = .fillEqually
        $0.spacing = 17
    }
    
    private let nameTextField = UITextField().then {
        $0.setTextField(placeholder: "이름을 입력해주세요", secure: false)
    }
    
    private let emailTextField = UITextField().then {
        $0.setTextField(placeholder: "이메일 또는 휴대전화", secure: false)
    }
    
    private let pwTextField = UITextField().then {
        $0.setTextField(placeholder: "비밀번호 입력", secure: true)
    }
        
    private lazy var showButton = UIButton().then {
        var configShow = UIButton.Configuration.plain()
        configShow.title = "비밀번호 표시"
        configShow.baseForegroundColor = .black
        configShow.baseBackgroundColor = .clear
        configShow.imagePlacement = .leading
        configShow.imagePadding = 10
        $0.configuration = configShow
        $0.addTarget(self, action: #selector(touchupShowButton(_:)), for: .touchUpInside)
        $0.configurationUpdateHandler = { btn in
            var config = btn.configuration
            config?.image = btn.isSelected ? Const.Image.check : Const.Image.uncheck
            btn.configuration = config
        }
    }
    
    private let signupButton = GoogleButton().then {
        $0.setUI(title: "다음")
        $0.addTarget(self, action: #selector(touchupSignupButton(_:)), for: .touchUpInside)
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setupAutoLayout()
        setupTextField()
        hideKeyboard()
    }
    
    // MARK: - Custom Method
    
    private func configUI() {
        view.backgroundColor = .white
    }
    
    private func setupAutoLayout() {
        view.addSubviews([logoImageView, signupLabel,
                          fieldStackView, showButton, signupButton])
        fieldStackView.addArrangedSubviews([nameTextField, emailTextField, pwTextField])
        
        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(110)
            make.centerX.equalToSuperview()
        }
        
        signupLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(23)
            make.centerX.equalToSuperview()
        }
        
        nameTextField.snp.makeConstraints { make in
            make.height.equalTo(48)
        }
        
        fieldStackView.snp.makeConstraints { make in
            make.top.equalTo(signupLabel.snp.bottom).offset(128)
            make.leading.trailing.equalToSuperview().inset(22)
            make.centerX.equalToSuperview()
        }

        showButton.snp.makeConstraints { make in
            make.top.equalTo(fieldStackView.snp.bottom).offset(17)
            make.leading.equalToSuperview().inset(11)
        }
        
        signupButton.snp.makeConstraints { make in
            make.top.equalTo(fieldStackView.snp.bottom).offset(110)
            make.leading.trailing.equalToSuperview().inset(22)
            make.height.equalTo(42)
        }
    }
    
    private func setupTextField() {
        nameTextField.delegate = self
        emailTextField.delegate = self
        pwTextField.delegate = self
        [nameTextField, emailTextField, pwTextField].forEach {
            $0.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
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
            signupButton.isUserInteractionEnabled = false
            signupButton.backgroundColor = .lineGray
        } else {
            signupButton.isUserInteractionEnabled = true
            signupButton.backgroundColor = .mainBlue
        }
    }
    
    @objc func touchupShowButton(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        pwTextField.isSecureTextEntry = !sender.isSelected
    }
    
    @objc func touchupSignupButton(_ sender: UIButton) {
        guard let name = nameTextField.text, !name.isEmpty,
              let email = emailTextField.text, !email.isEmpty,
              let pw = pwTextField.text, !pw.isEmpty else {
                  print("다 입력해주세요.")
                  return
              }
        
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: pw) { [weak self] (result, error) in
            guard let self = self else { return }
            if error != nil { // error가 nil이 아니다 => error에 뭐가 있다? => error가 있다는 뜻
                print("회원가입 실패", error?.localizedDescription)
                
            } else {
                // 데이터 추가
                let db = Firestore.firestore()
                var ref: DocumentReference? = nil
                ref = db.collection("users").addDocument(data: ["이름":name,
                                                                "이메일":email,
                                                                "uid":result!.user.uid]) { (error) in

                    if error != nil {
                        print(error?.localizedDescription ?? "사용자 데이터 저장 오류")
                    } else {
                        print("데이터 추가", ref!.documentID)
                    }
                }
                // home으로 화면전환
                let vc = CompleteVC()
                vc.name = self.nameTextField.text
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
            }
        }
    }
}

// MARK: - UITextFieldDelegate

extension SignUpVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case nameTextField: emailTextField.becomeFirstResponder()
        case emailTextField: pwTextField.becomeFirstResponder()
        case pwTextField: pwTextField.resignFirstResponder()
        default: break
        }
        return true
    }
}
