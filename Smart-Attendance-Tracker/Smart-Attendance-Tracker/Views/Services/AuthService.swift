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
        var request = URLRequest(url:url)
        request.httpMethod="POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        return request

    }
    private func performRequest(request: URLRequest, completion: @escaping (Result<String, Error>) -> Void) {
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data, let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                  let token = json["token"] as? String else {
                completion(.failure(NSError(domain: "", code: 500, userInfo: [NSLocalizedDescriptionKey: "Invalid Response"])))
                return
            }
            
            completion(.success(token))
        }.resume()
    }
    
    
}
