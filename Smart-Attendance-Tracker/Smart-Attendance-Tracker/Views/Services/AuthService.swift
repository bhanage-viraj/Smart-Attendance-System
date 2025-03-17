//
//  AuthService.swift
//  Smart-Attendance-Tracker
//
//  Created by Viraj Bhanage on 17/03/25.
//

import Foundation
class AuthService {
    static let shared = AuthService()
    private let baseURL = "http://3.95.186.173:8080/attendance/auth/login"
    private init() {}
    func login(email: String , password: String, completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/login") else {
                   completion(.failure(NSError(domain: "", code: 400, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
                   return
               }
        let body :[String : String] = ["email": email,"password": password]
        let request = makeRequest(url: url, body: body)
                
                performRequest(request: request, completion: completion)
        
        
    }
    private func makeRequest(url: URL, body: [String: String]) -> URLRequest {
        return URLRequest(url:url)
    }
    private func performRequest(request: URLRequest, completion: @escaping (Result<String, Error>) -> Void) {
        
    }
    
}
