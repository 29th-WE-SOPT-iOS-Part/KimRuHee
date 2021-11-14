//
//  AuthManager.swift
//  Sopt29th-Assignment
//
//  Created by Thisisme Hi on 2021/11/12.
//

import Foundation

import Moya

class AuthManager {
    
    // MARK: - Static Properties
    
    static let shared: AuthManager = AuthManager()
    
    // MARK: - Network Properties

    private let authProvider = MoyaProvider<AuthService>(plugins: [NetworkLoggerPlugin()])
    public var authModel: AuthModel?
    
    // MARK: - POST : Login
    
    func fetchLogin(email: String, password: String, completion: @escaping (() -> ())) {
        let param = LoginRequest.init(email, password)
        authProvider.request(.login(param: param)) { result in
            switch result {
            case .success(let result):
                do {
                    self.authModel = try result.map(AuthModel.self)
                    completion()
                    
                } catch(let err) {
                    print(err.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    // MARK: - POST : SignUp
    
    func fetchSignUp(email: String, name: String, password: String, completion: @escaping (() -> ())) {
        let param = SignUpRequest.init(email, name, password)
        authProvider.request(.signUp(param: param)) { result in
            switch result {
            case .success(let result):
                do {
                    self.authModel = try result.map(AuthModel.self)
                    completion()
                } catch(let err) {
                    print(err.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}
