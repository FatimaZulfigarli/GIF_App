////
////  NetworkConstants.swift
////  Giphy
////
////  Created by Fatya on 27.07.24.
////
//import Foundation
//import Alamofire
//
//enum BaseURL {
//    case v1
//    case v2
//    
//    var path: String {
//        switch self {
//        case .v1:
//            return NetworkConstants.baseURL + "v1/"
//        case .v2:
//            return NetworkConstants.baseURL + "v2/"
//        }
//    }
//}
//
//enum Endpoint {
//    case gifsTrending
//    case stickersTrending
//    case emoji
//    case emojiVariations(emojiId: String)
//    case gifsSearch(query: String) // Add this for GIF search
//    case stickersSearch(query: String) // Add this for sticker search
//       
//       var path: String {
//           switch self {
//           case .gifsTrending:
//               return BaseURL.v1.path + "gifs/trending"
//           case .stickersTrending:
//               return BaseURL.v1.path + "stickers/trending"
//           case .emoji:
//               return BaseURL.v2.path + "emoji"
//           case .emojiVariations(let emojiId):
//               return BaseURL.v2.path + "emoji/\(emojiId)/variations"
////           case .gifsSearch(let query):
////               return BaseURL.v1.path + "gifs/search?q=\(query)"
//           case .gifsSearch(let query):
//               return BaseURL.v1.path + "gifs/search?api_key=\(NetworkConstants.apiKey)&q=\(query)"
//           case .stickersSearch(let query):
//               return BaseURL.v1.path + "stickers/search?q=\(query)"
//           }
//       }
//   }
//
//class NetworkConstants {
//    static let baseURL = "https://api.giphy.com/"
//    static let apiKey = "uZQeYKsD27WiYMFwwTbJGVsLsRu3YFzv"
//    
//    static func getUrl(for endpoint: Endpoint) -> String {
//        return "\(endpoint.path)?api_key=\(apiKey)"
//    }
//}
//
////this is my GIF endpoint
////api.giphy.com/v1/gifs/trending
////this is my sticker endpoint
////api.giphy.com/v1/stickers/trending
////
////this is my emoji endpoint
////api.giphy.com/v2/emoji
////
////this is my emoji variation endpoint
////api.giphy.com/v2/emoji/{gif_id}/variations
//
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
    case emojiVariations(emojiId: String)
    case gifsSearch(query: String)
    case stickersSearch(query: String)
    
    var path: String {
        switch self {
        case .gifsTrending:
            return BaseURL.v1.path + "gifs/trending?api_key=\(NetworkConstants.apiKey)"
        case .stickersTrending:
            return BaseURL.v1.path + "stickers/trending?api_key=\(NetworkConstants.apiKey)"
        case .emoji:
            return BaseURL.v2.path + "emoji?api_key=\(NetworkConstants.apiKey)"
        case .emojiVariations(let emojiId):
            return BaseURL.v2.path + "emoji/\(emojiId)/variations?api_key=\(NetworkConstants.apiKey)"
        case .gifsSearch(let query):
            return BaseURL.v1.path + "gifs/search?api_key=\(NetworkConstants.apiKey)&q=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? query)"
        case .stickersSearch(let query):
            return BaseURL.v1.path + "stickers/search?api_key=\(NetworkConstants.apiKey)&q=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? query)"
        }
    }
}

class NetworkConstants {
    static let baseURL = "https://api.giphy.com/"
    static let apiKey = "uZQeYKsD27WiYMFwwTbJGVsLsRu3YFzv"
}
