//
//  ViewController.swift
//  Fourth Seminar
//
//  Created by Thisisme Hi on 2021/10/30.
//

import UIKit

import Alamofire

class ViewController: UIViewController {
        
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func signinButton(_ sender: Any) {
        requestLogin()
        getUser()
    }
    
    func simpleAlert(title: String, message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인" ,style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

extension ViewController {
    func requestLogin() {
        LoginService.shared.login(email: emailTextField.text ?? "", password: pwTextField.text ?? "") { responseData in
            switch responseData {
            case .success(let loginResponse):
                guard let response = loginResponse as? AuthModel else { return }
                if let userData = response.data {
                    self.simpleAlert(title: response.message,
                                     message: "\(userData.name)님 환영합니다.")
                }
            case .requestErr(let msg):
                print("requestErr \(msg)")
            case .pathErr:
                print("pathErr")
            case .serverErr:
                print("serverErr")
            case .networkFail:
                print("networkFail")
            }
        }
    }
    
    func getUser() {
        LoginService.shared.readUserData(userID: 1) { responseData in
                switch responseData {
                case .success(let loginResponse):
                    guard let response = loginResponse as? AuthModel else { return }
                    if let userData = response.data {
                        self.resultLabel.text = userData.name
                    }
                case .requestErr(let msg):
                    print("requestErr \(msg)")
                case .pathErr:
                    print("pathErr")
                case .serverErr:
                    print("serverErr")
                case .networkFail:
                    print("networkFail")
            }
        }
    }
}
