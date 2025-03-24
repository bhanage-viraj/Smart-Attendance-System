//
//  AuthService.swift
//  Smart-Attendance-Tracker
//


import Foundation

enum AuthError: Error {
    case invalidCredentials
    case invalidResponse
    case invalidURL
    case networkError(Error)
    case noData
    case decodingError
}

class AuthService {
    static let shared = AuthService()
    private let baseURL = "http://3.95.186.173:8080/attendance/auth"
    
    private init() {}
    
    // MARK: - Email & Password Authentication
    func login(email: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/login") else {
            completion(.failure(AuthError.invalidURL))
            return
        }
        
        let body: [String: String] = [
            "email": email,
            "password": password
        ]
        
        let request = makeRequest(url: url, body: body)
        performRequest(request: request) { result in
            switch result {
            case .success(let token):
                // Save token to TokenManager
                TokenManager.saveToken(token)
                completion(.success(token))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // MARK: - Google Authentication
    func loginWithGoogle(token: String, completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/google") else {
            completion(.failure(AuthError.invalidURL))
            return
        }
        
        let body: [String: String] = ["token": token]
        let request = makeRequest(url: url, body: body)
        
        performRequest(request: request) { result in
            switch result {
            case .success(let token):
                // Save token to TokenManager
                TokenManager.saveToken(token)
                completion(.success(token))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // MARK: - Logout
    func logout() {
        TokenManager.deleteToken()
    }
    
    // MARK: - Private Helper Methods
    private func makeRequest(url: URL, body: [String: Any]) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        return request
    }
    // update to handel https satus code
    private func performRequest(request: URLRequest, completion: @escaping (Result<String, Error>) -> Void) {
            URLSession.shared.dataTask(with: request) { data, response, error in
                // Handle network errors
                if let error = error {
                    completion(.failure(AuthError.networkError(error)))
                    return
                }
                
                // Handle HTTP status codes
                if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode != 200 {
                        completion(.failure(AuthError.invalidResponse))
                        return
                    }
                }
                
                // Handle missing data
                guard let data = data else {
                    completion(.failure(AuthError.noData))
                    return
                }
                
                // Parse response
                do {
                    guard let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                          let token = json["token"] as? String else {
                        completion(.failure(AuthError.decodingError))
                        return
                    }
                    
                    completion(.success(token))
                } catch {
                    completion(.failure(AuthError.decodingError))
                }
            }.resume()
        }
    
}




