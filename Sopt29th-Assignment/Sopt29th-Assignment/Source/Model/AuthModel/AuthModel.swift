//
//  AuthModel.swift
//  Sopt29th-Assignment
//
//  Created by Thisisme Hi on 2021/11/12.
//

import Foundation

// MARK: - AuthModel

struct AuthModel: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: AuthInfo?
}

// MARK: - AuthInfo

struct AuthInfo: Codable {
    let id: Int
    let name, email: String
}
