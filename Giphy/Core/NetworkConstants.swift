//
//  NetworkConstants.swift
//  Giphy
//
//  Created by Fatya on 27.07.24.
//
import Foundation
import Alamofire

enum BaseURL {
    case v1
    case v2
    
    var path: String {
        switch self {
        case .v1:
            return NetworkConstants.baseURL + "v1/"
        case .v2:
            return NetworkConstants.baseURL + "v2/"
        }
    }
}

enum Endpoint {
    case gifsTrending
    case stickersTrending
    case emoji
    case emojiVariations(gifId: String)
    
    var path: String {
        switch self {
        case .gifsTrending:
            return BaseURL.v1.path + "gifs/trending"
        case .stickersTrending:
            return BaseURL.v1.path + "stickers/trending"
        case .emoji:
            return BaseURL.v2.path + "emoji"
        case .emojiVariations(let gifId):
            return BaseURL.v2.path + "emoji/\(gifId)/variations"
        }
    }
}

class NetworkConstants {
    static let baseURL = "https://api.giphy.com/"
    static let apiKey = "uZQeYKsD27WiYMFwwTbJGVsLsRu3YFzv"
    
    static func getUrl(for endpoint: Endpoint) -> String {
        return "\(endpoint.path)?api_key=\(apiKey)"
    }
}

//this is my GIF endpoint
//api.giphy.com/v1/gifs/trending
//this is my sticker endpoint
//api.giphy.com/v1/stickers/trending
//
//this is my emoji endpoint
//api.giphy.com/v2/emoji
//
//this is my emoji variation endpoint
//api.giphy.com/v2/emoji/{gif_id}/variations
