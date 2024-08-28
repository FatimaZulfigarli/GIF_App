////
////  NetworkManager.swift
////  Giphy
////
////  Created by Fatya on 27.07.24.
////
////
////
////
//import Foundation
//import Alamofire
//
//class NetworkManager {
//    static func request<T: Codable>(model: T.Type,
//                                    endpoint: Endpoint,
//                                    method: HTTPMethod = .get,
//                                    parameters: Parameters? = nil,
//                                    encoding: ParameterEncoding = URLEncoding.default,
//                                    completion: @escaping((T?, String?) -> Void)) {
//        let url = NetworkConstants.getUrl(for: endpoint)
//
//        AF.request(url,
//                   method: method,
//                   parameters: parameters,
//                   encoding: encoding).responseData { response in
//            switch response.result {
//            case .success(let data):
//                // Log the raw response data
//                if let jsonString = String(data: data, encoding: .utf8) {
//                    print("Response JSON: \(jsonString)")
//                }
//                // Try to decode the data
//                do {
//                    let decodedData = try JSONDecoder().decode(T.self, from: data)
//                    completion(decodedData, nil)
//                } catch {
//                    completion(nil, "Decoding error: \(error)")
//                }
//            case .failure(let error):
//                completion(nil, error.localizedDescription)
//            }
//        }
//    }
//}

import Foundation
import Alamofire
//
//class NetworkManager {
//    static func request<T: Codable>(model: T.Type,
//                                    endpoint: Endpoint,
//                                    method: HTTPMethod = .get,
//                                    parameters: Parameters? = nil,
//                                    encoding: ParameterEncoding = URLEncoding.default,
//                                    completion: @escaping((T?, String?) -> Void)) {
////        let url = NetworkConstants.getUrl(for: endpoint)
//        print("Requesting URL: \(endpoint.path)")
//        
//        AF.request(endpoint.path,
//                   method: method,
//                   parameters: parameters,
//                   encoding: encoding).responseData { response in
//            switch response.result {
//            case .success(let data):
//                if let jsonString = String(data: data, encoding: .utf8) {
//                    print("Response JSON: \(jsonString)")
//                }
//                do {
//                    let decodedData = try JSONDecoder().decode(T.self, from: data)
//                    completion(decodedData, nil)
//                } catch { //emojide problem yashadigim ucun bunlari add etdim
//                    print("Decoding error: \(error)")
//                    if let decodingError = error as? DecodingError {
//                        switch decodingError {
//                        case .typeMismatch(let type, let context):
//                            print("Type mismatch: expected \(type) at path: \(context.codingPath)")
//                        case .valueNotFound(let type, let context):
//                            print("Value not found: expected \(type) at path: \(context.codingPath)")
//                        case .keyNotFound(let key, let context):
//                            print("Key not found: \(key) at path: \(context.codingPath)")
//                        case .dataCorrupted(let context):
//                            print("Data corrupted at path: \(context.codingPath)")
//                        @unknown default:
//                            print("Unknown decoding error")
//                        }
//                    }
//                    completion(nil, "Decoding error: \(error)")
//                }
//            case .failure(let error):
//                print("Network error: \(error)")
//                completion(nil, error.localizedDescription)
//            }
//        }
//    }
//}

class NetworkManager {
    static func request<T: Codable>(model: T.Type,
                                    endpoint: Endpoint,
                                    method: HTTPMethod = .get,
                                    parameters: Parameters? = nil,
                                    encoding: ParameterEncoding = URLEncoding.default,
                                    completion: @escaping ((T?, String?) -> Void)) {
        print("Requesting URL: \(endpoint.path)")
        
        AF.request(endpoint.path,
                   method: method,
                   parameters: parameters,
                   encoding: encoding).responseData { response in
            switch response.result {
            case .success(let data):
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("Response JSON: \(jsonString)")
                }
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    completion(decodedData, nil)
                } catch {
                    print("Decoding error: \(error)")
                    if let decodingError = error as? DecodingError {
                        switch decodingError {
                        case .typeMismatch(let type, let context):
                            print("Type mismatch: expected \(type) at path: \(context.codingPath)")
                        case .valueNotFound(let type, let context):
                            print("Value not found: expected \(type) at path: \(context.codingPath)")
                        case .keyNotFound(let key, let context):
                            print("Key not found: \(key) at path: \(context.codingPath)")
                        case .dataCorrupted(let context):
                            print("Data corrupted at path: \(context.codingPath)")
                        @unknown default:
                            print("Unknown decoding error")
                        }
                    }
                    completion(nil, "Decoding error: \(error)")
                }
            case .failure(let error):
                print("Network error: \(error)")
                completion(nil, error.localizedDescription)
            }
        }
    }
}
