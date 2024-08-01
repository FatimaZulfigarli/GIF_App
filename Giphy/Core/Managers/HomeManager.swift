//
//  HomeManager.swift
//  Giphy
//
//  Created by Fatya on 27.07.24.
//

import Foundation
import Alamofire

class HomeManager {
    func fetchTrendingGIFs(completion: @escaping (GIFModel?, String?) -> Void) {
        NetworkManager.request(model: GIFModel.self, endpoint: .gifsTrending) { response, error in
            if let error = error {
                completion(nil, error)
            } else {
                // Log the raw response data if needed
                if let jsonData = try? JSONEncoder().encode(response),
                   let jsonString = String(data: jsonData, encoding: .utf8) {
                   
                }
                completion(response, nil)
            }
        }
    }
    
    func fetchTrendingStickers(completion: @escaping (StickerModel?, String?) -> Void) {
        NetworkManager.request(model: StickerModel.self, endpoint: .stickersTrending) { response, error in
            if let error = error {
                completion(nil, error)
            } else {
                // Log the raw response data if needed
                if let jsonData = try? JSONEncoder().encode(response),
                   let jsonString = String(data: jsonData, encoding: .utf8) {
                   
                }
                completion(response, nil)
            }
        }
    }
}
