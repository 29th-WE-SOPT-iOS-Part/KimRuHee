//
//  LoginRequest.swift
//  Sopt29th-Assignment
//
//  Created by Thisisme Hi on 2021/11/12.
//

import Foundation

/**
 로그인 시 사용하는 데이터 요청 바디입니다
 */

struct LoginRequest: Codable {
    var email: String
    var password: String
    
    init(_ email: String, _ password: String) {
        self.email = email
        self.password = password
    }
}

