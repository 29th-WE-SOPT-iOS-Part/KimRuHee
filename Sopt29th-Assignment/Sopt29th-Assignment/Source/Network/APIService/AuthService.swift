//
//  AuthService.swift
//  Sopt29th-Assignment
//
//  Created by Thisisme Hi on 2021/11/12.
//

import Foundation

import Moya

enum AuthService {
    case login(param: LoginRequest)
    case signUp(param: SignUpRequest)
}

extension AuthService: TargetType {
    var baseURL: URL {
        return URL(string: GeneralAPI.baseURL)!
    }
    
    var path: String {
        switch self {
        case .login:
            return "/user/login"
        case .signUp:
            return "/user/signup"
        }
    }
    
    var method: Moya.Method {
        switch self {
        default:
            return .post
        }
    }
    
    var sampleData: Data {
        return "@@".data(using: .utf8)!
    }
    
    var task: Task {
        switch self {
        case .login(let param):
            return .requestJSONEncodable(param)
        case .signUp(let param):
            return .requestJSONEncodable(param)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return ["Content-Type": "application/json"]
        }
    }
}

