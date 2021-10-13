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
    private let logoLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 50)
        $0.textColor = .mainBlue
        $0.text = "Google"
    }
    
    private let signupLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 35)
        $0.textColor = .black
        $0.text = "회원가입"
    }
    
    private lazy var fieldStackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .fill
        $0.distribution = .fillEqually
        $0.spacing = 20
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
        
    lazy var showButton = UIButton().then {
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
    
    private let signupButton = UIButton().then {
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
        configUI()
        setupAutoLayout()
        setupTextField()
        hideKeyboard()
    }
    
    // MARK: - Custom Method
    func configUI() {
        view.backgroundColor = .white
    }
    
    func setupAutoLayout() {
        view.addSubviews([logoLabel, signupLabel, fieldStackView,
                          showButton, signupButton])
        fieldStackView.addArrangedSubviews([nameTextField, emailTextField, pwTextField])
        
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
            signupButton.backgroundColor = .lightGray
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
        
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: pw) { [self] (result, error) in
            if error != nil { // error가 nil이 아니다 => error에 뭐가 있다? => error가 있다는 뜻
                print("회원가입 실패")
                
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
                present(vc, animated: true, completion: nil)
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
