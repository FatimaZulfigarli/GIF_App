//
//  NetworkManager.swift
//  Giphy
//
//  Created by Fatya on 27.07.24.
//
//
//
//
import Foundation
import Alamofire

class NetworkManager {
    static func request<T: Codable>(model: T.Type,
                                    endpoint: Endpoint,
                                    method: HTTPMethod = .get,
                                    parameters: Parameters? = nil,
                                    encoding: ParameterEncoding = URLEncoding.default,
                                    completion: @escaping((T?, String?) -> Void)) {
        let url = NetworkConstants.getUrl(for: endpoint)
        
        AF.request(url,
                   method: method,
                   parameters: parameters,
                   encoding: encoding).responseData { response in
            switch response.result {
            case .success(let data):
                // Log the raw response data
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("Response JSON: \(jsonString)")
                }
                // Try to decode the data
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    completion(decodedData, nil)
                } catch {
                    completion(nil, "Decoding error: \(error)")
                }
            case .failure(let error):
                completion(nil, error.localizedDescription)
            }
        }
    }
}
//import Foundation
//import Alamofire
//
//class NetworkManager {
//   
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
//                   encoding: encoding).responseDecodable(of: T.self) { response in
//            switch response.result {
//            case .success(let data):
//                completion(data, nil)
//            case .failure(let error):
//                completion(nil, error.localizedDescription)
//            }
//        }
//    }
//}
