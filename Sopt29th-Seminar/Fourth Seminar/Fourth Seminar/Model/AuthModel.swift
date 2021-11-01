//
//  AuthModel.swift
//  Fourth Seminar
//
//  Created by Thisisme Hi on 2021/10/30.
//

import Foundation

// MARK: - AuthModel
struct AuthModel: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: LoginInfo?
}

// MARK: - Auth
struct LoginInfo: Codable {
    let id: Int
    let name, email: String
}
