//
//  AuthModel.swift
//  Sopt29th-Assignment
//
//  Created by Thisisme Hi on 2021/11/12.
//

import Foundation

/**
 로그인 및 회원가입 시 필요한 정보들을 반환하는 데이터 모델입니다.
 */

// MARK: - AuthModel

struct AuthModel: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: AuthData?
}

// MARK: - AuthInfo

struct AuthData: Codable {
    let id: Int
    let name, email: String
}
