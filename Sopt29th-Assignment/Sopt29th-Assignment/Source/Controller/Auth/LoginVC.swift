//
//  LoginVC.swift
//  Sopt29th-Assignment
//
//  Created by Thisisme Hi on 2021/10/05.
//

import UIKit

import AuthenticationServices
import CryptoKit
import Firebase
import FirebaseAuth
import SnapKit
import Then

class LoginVC: UIViewController {
    
    // MARK: - Properties
    
    fileprivate var currentNonce: String?
    
    private let networkMG = AuthManager.shared

    private let logoImageView = UIImageView().then {
        $0.image = Const.Image.logo
        $0.contentMode = .scaleAspectFit
    }
    
    private let loginLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 24, weight: .semibold)
        $0.text = "로그인"
    }
    
    private let explainLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14, weight: .regular)
        $0.numberOfLines = 0
        $0.text = Const.Text.Description
        $0.addSpacing(kernValue: 0, paragraphValue: 7)
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
    
    private let appleButton = ASAuthorizationAppleIDButton().then {
        $0.addTarget(self, action: #selector(touchUpAppleButton(_:)), for: .touchUpInside)
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
    }
    
    private let signupButton = BaseButton().then {
        $0.setUI(title: "계정만들기")
        $0.addTarget(self, action: #selector(touchupSignupButton(_:)), for: .touchUpInside)
    }
    
    private let signInButton = GoogleButton().then {
        $0.setUI(title: "다음")
        $0.addTarget(self, action: #selector(touchupSignInButton(_:)), for: .touchUpInside)
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
        view.addSubviews([logoImageView, loginLabel, explainLabel,
                          fieldStackView, appleButton, signupButton, signInButton])
        fieldStackView.addArrangedSubviews([nameTextField, emailTextField, pwTextField])
        
        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(110)
            make.centerX.equalToSuperview()
        }
        
        loginLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(23)
            make.centerX.equalToSuperview()
        }
        
        explainLabel.snp.makeConstraints { make in
            make.top.equalTo(loginLabel.snp.bottom).offset(14)
            make.leading.trailing.equalToSuperview().inset(40)
            make.centerX.equalToSuperview()
        }
        
        nameTextField.snp.makeConstraints { make in
            make.height.equalTo(48)
        }
        
        fieldStackView.snp.makeConstraints { make in
            make.top.equalTo(loginLabel.snp.bottom).offset(128)
            make.leading.trailing.equalToSuperview().inset(22)
            make.centerX.equalToSuperview()
        }
        
        appleButton.snp.makeConstraints { make in
            make.top.equalTo(fieldStackView.snp.bottom).offset(17)
            make.leading.trailing.equalToSuperview().inset(22)
            make.height.equalTo(48)
        }
        
        signupButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(22)
            make.centerY.equalTo(signInButton.snp.centerY)
        }
        
        signInButton.snp.makeConstraints { make in
            make.top.equalTo(fieldStackView.snp.bottom).offset(110)
            make.trailing.equalToSuperview().inset(22)
            make.width.equalTo(74)
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
    
    // MARK: - Apple 로그인
    
    @objc func touchUpAppleButton(_ sender: UIButton) {
        let request = createAppleIDRequest()
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    @available(iOS 13, *)
    func createAppleIDRequest() -> ASAuthorizationAppleIDRequest {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        // 애플로그인은 사용자에게서 2가지 정보를 요구함
        request.requestedScopes = [.fullName, .email]

        let nonce = randomNonceString()
        request.nonce = sha256(nonce)
        currentNonce = nonce
        
        return request
    }
    
    @available(iOS 13, *)
    private func sha256(_ input: String) -> String {
      let inputData = Data(input.utf8)
      let hashedData = SHA256.hash(data: inputData)
      let hashString = hashedData.compactMap {
        return String(format: "%02x", $0)
      }.joined()

      return hashString
    }
    
    
    func getUserProfile() {
        /// 사용자 프로필 가져오기
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
            signInButton.backgroundColor = .lineGray
            
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
                  return
              }
    
        networkMG.fetchLogin(email: email, password: pw) {
            let loginAlert = UIAlertController(title: "로그인",
                                               message: self.networkMG.authModel?.message,
                                               preferredStyle: .alert)
            let confirmAction = UIAlertAction(title: "확인", style: .default) { [weak self] _ in
                guard let self = self else { return }
                if self.networkMG.authModel?.status == 200 {
                    let vc = CompleteVC()
                    vc.name = self.networkMG.authModel?.data?.name
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true, completion: nil)
                }
            }
            loginAlert.addAction(confirmAction)
            self.present(loginAlert, animated: true, completion: nil)
        }
        
        /// 이 부분은 파이어베이스 이메일 인증 로그인이라 잠시 주석처리를 해두었습니다.
//        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: pw) { [weak self] user, error in
//            guard let self = self else { return }
//            /// 에러가 나거나 유저가 없을 경우
//            if let error = error, user == nil {
//                let alert = UIAlertController(
//                    title: "로그인 실패",
//                    message: error.localizedDescription,
//                    preferredStyle: .alert)
//
//                alert.addAction(UIAlertAction(title: "확인", style: .default))
//                self.present(alert, animated: true, completion: nil)
//
//            } else { /// 성공이면 화면전환하고 프로필 가져오기
//                self.getUserProfile()
//            }
//        }
    }
}

// MARK: - UITextFieldDelegate

extension LoginVC: UITextFieldDelegate {
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

// MARK: - ASAuthorizationControllerDelegate

@available(iOS 13.0, *)
extension LoginVC: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            // 몇 가지 표준 키 검사를 수행
            // 1. 현재 nonce가 설정되어 있는지 확인
            guard let nonce = currentNonce else {
                fatalError("Invalid state: A login callback was received, but no login request was sent.")
            }
            
            // 2. ID 토큰을 검색하여
            guard let appleIDtoken = appleIDCredential.identityToken else {
                print("Unable to fetch identity token")
                return
            }
            
            // 문자열로 변환
            guard let idTokenString = String(data: appleIDtoken, encoding: .utf8) else {
                print("Unable to serialize token string from data: \(appleIDtoken.debugDescription)")
                return
            }
            
            // nonce와 IDToken을 사용하여 OAuth 공급자에게 방금 로그인한 사용자를 나타내는 자격증명을 생성하도록 요청
            let credential = OAuthProvider.credential(withProviderID: "apple.com",
                                                      idToken: idTokenString,
                                                      rawNonce: nonce)
            
            // 이 자격증명을 사용하여 Firebase에 로그인할 것이다.
            // Firebase는 자격증명을 확인하고 유효한 경우 사용자를 로그인시켜 줄 것이다.
            // 새 사용자인 경우에 Firebase는 ID 토큰에 제공된 정보를 사용하여 새 사용자 계정을 만들 것이다.
            FirebaseAuth.Auth.auth().signIn(with: credential) { [weak self] (authDataResult, error) in
                guard let self = self else { return }
                // 인증 결과에서 Firebase 사용자를 검색하고 사용자 정보를 표시할 수 있다.
                if let user = authDataResult?.user {
                    print("애플 로그인 성공!", user.uid, user.email ?? "-")
                    let vc = CompleteVC()
                    vc.name = user.email ?? "애플로그인 가입자"
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true, completion: nil)
                }
                
                if error != nil {
                    print(error?.localizedDescription ?? "error" as Any)
                    return
                }
            }
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
        print("Sign in with Apple errored: \(error)")
      }
}

// MARK: - ASAuthorizationControllerPresentationContextProviding

@available(iOS 13.0, *)
extension LoginVC: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}

// Adapted from https://auth0.com/docs/api-auth/tutorials/nonce#generate-a-cryptographically-random-nonce
private func randomNonceString(length: Int = 32) -> String {
  precondition(length > 0)
  let charset: Array<Character> =
      Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
  var result = ""
  var remainingLength = length

  while remainingLength > 0 {
    let randoms: [UInt8] = (0 ..< 16).map { _ in
      var random: UInt8 = 0
      let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
      if errorCode != errSecSuccess {
        fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
      }
      return random
    }

    randoms.forEach { random in
      if remainingLength == 0 {
        return
      }

      if random < charset.count {
        result.append(charset[Int(random)])
        remainingLength -= 1
      }
    }
  }
  return result
}
