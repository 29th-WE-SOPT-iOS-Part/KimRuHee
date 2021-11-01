//
//  LoginService.swift
//  Fourth Seminar
//
//  Created by Thisisme Hi on 2021/10/30.
//

import Foundation

import Alamofire

struct LoginService {
    static let shared = LoginService()
    
    func login(email: String,
               password: String,
               completion: @escaping (NetworkResult<Any>) -> (Void)) {
        
        let url = APIConstants.loginURL
        let header: HTTPHeaders = ["Content-Type" : "application/json"]
        
        /// post라서 body가 있음
        let body: Parameters = ["email" : email, "password" : password]
        
        let dataRequest = AF.request(url,
                                     method: .post,
                                     parameters: body,
                                     encoding: JSONEncoding.default,
                                     headers: header)
        
        // request의 responseData 함수 호출함으로서 데이터 통신 시작
        dataRequest.responseData { dataResponse in
            switch dataResponse.result {
            case .success:
                guard let statusCode = dataResponse.response?.statusCode else { return }
                guard let value = dataResponse.value else { return }
                let networkResult = self.judgeLoginStatus(by: statusCode, value)
                completion(networkResult)
            case .failure(let err):
                print(err)
                completion(.networkFail)
            }
        }
    }
    
    func readUserData(userID: Int,
                      completion: @escaping (NetworkResult<Any>) -> (Void)) {
        
        let url = APIConstants.readUserURL + "\(userID)"
        let header: HTTPHeaders = ["Content-Type" : "application/json"]
        
        let dataRequest = AF.request(url,
                                     method: .get,
                                     encoding: JSONEncoding.default,
                                     headers: header)
        
        dataRequest.responseData { dataResponse in
            switch dataResponse.result {
            case .success:
                guard let statusCode = dataResponse.response?.statusCode else { return }
                guard let value = dataResponse.value else { return }
                let networkResult = self.judgeLoginStatus(by: statusCode, value)
                completion(networkResult)
            case .failure(let err):
                print(err)
                completion(.networkFail)
            }
        }
    }
    
    private func judgeLoginStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        switch statusCode {
        case 200: return isValidLoginData(data: data)
        case 400: return .pathErr
        case 500: return .serverErr
        default: return .networkFail
        }
    }
    
    // json 파일을 swift로 변환하기 위한 함수
    private func isValidLoginData(data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(AuthModel.self, from: data) else { return .pathErr }
        return .success(decodedData)
    }
}
