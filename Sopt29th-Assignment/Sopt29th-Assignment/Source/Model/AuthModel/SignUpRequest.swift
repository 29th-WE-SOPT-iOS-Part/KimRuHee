//
//  SignUpRequest.swift
//  Sopt29th-Assignment
//
//  Created by Thisisme Hi on 2021/11/12.
//

import Foundation

/**
 회원가입 시 사용하는 데이터 요청 바디입니다
 */

struct SignUpRequest: Codable {
    var email: String
    var name: String
    var password: String
    
    init(_ email: String, _ name: String ,_ password: String) {
        self.email = email
        self.name = name
        self.password = password
    }
}
