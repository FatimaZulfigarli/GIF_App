//
//  NetworkManager.swift
//  Giphy
//
//  Created by Fatya on 27.07.24.
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
        print(url)
        AF.request(url,
                   method: method,
                   parameters: parameters,
                   encoding: encoding,
                   headers: NetworkConstants.header).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let data):
                completion(data, nil)
            case .failure(let error):
                print(error.localizedDescription)
                completion(nil, error.localizedDescription)
            }
        }
    }
}
